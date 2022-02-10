# This Python file uses the following encoding: utf-8
import os, threading, requests
from pathlib import Path
import sys
import datetime
import json
import time
import threading

from PySide2.QtGui import QGuiApplication, QIcon
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QObject, Slot, Signal, QTimer, QUrl
from PySide2 import QtSvg

def colConv(num):
    if num == 0: return 'green'
    if num == 3: return 'red'
    return

class MainWindow(QObject,threading.Thread):
    def __init__(self):
        QObject.__init__(self)
        threading.Thread.__init__(self)

        # QTimer - Run Timer
        self.timer = QTimer()
        self.timer.timeout.connect(lambda: self.setTime())
        self.timer.start(1000)
        
        self.srvCat = 'http://127.0.0.1:8080/'
        self.dataStructure = {}
        self.context = {'gym':None,'room':None,'menu':None}
        self.updateFlag = {'gyms':False,'rooms':False,'devices':False}
        self.status = {}
        
    # Ale signals
    
    updElem = Signal('QVariant')
    gymSig = Signal(list)
    roomSig = Signal(list)
    devSig = Signal(list)
    devListSig = Signal(list)
    adjSig = Signal(list)
    connStatus = Signal('Qvariant')

    # Signal Set Data
    printTime = Signal(str)
    
    def start_engine(self):
        self.engine = QQmlApplicationEngine()
        self.start()


    # Set Timer Function

    def setTime(self):
        now = datetime.datetime.now()
        formatDate = now.strftime("Now is %H:%M:%S of %Y/%m/%d")
        #print(formatDate)
        self.printTime.emit(formatDate)
        
    @Slot(str,str)
    def retrieveData(self,gymName,roomName):
        if roomName == 'None':
            #roomList = list(self.dataStructure[gymName].keys())
            if gymName == "San Donato":
                roomList = self.l2
            else:
                roomList = self.l2_bis
            self.roomSig.emit(roomList)
        else:
            #deviceList = list(self.dataStructure[gymName][roomName].keys())
            deviceList = self.l3
            print(deviceList)
            self.deviceSig.emit(deviceList)
            

    

        

    @Slot(str, str, str, int)
    def jsonCreator(self, gymName, roomName1, roomName2, gymLength):
        print(f"Gym name: {gymName}")
        print(f"Gym name: {gymLength}")
        print(f"Room1 name: {roomName1}")
        print(f"Room2 name: {roomName2}")
        # print(f"Current text in combobox: {currentText}")
        self.setGymName.emit("The Gym name is: " + gymName)
        if(gymName == '1'):
            self.setModel.emit(["primo", "secondo", "terzo", "quarto"])
            # Con questo si possono settare dinamicamente gli elementi dentro
            # la ComboBox
        elif(gymName == '2'):
            self.setModel.emit(["uno", "due", "tre", "quattro"])
            # Con questo si possono settare dinamicamente gli elementi dentro
            # la ComboBox
        else:
            self.setModel.emit([])

        od_conf = {
            "gym": gymName,
            "room1": roomName1,
            "room2": roomName2

        }

        self.od_conf = od_conf

    @Slot(str)
    def jsonSave(self, value):
        with open("od_conf.json", 'w') as fp:
            json.dump(self.od_conf, fp, indent=4)
            print(f"File salvato {value}")
            
            
            
    ################# ALE'S BACKEND ###############

    def run(self):
        while True:
            self.updateData()
            time.sleep(1)

            


    # FRONT-END METHODS

    # INPUT: Palestra e stanza di cui si vuole ricavare la lista dei dispositivi
    # OUTPUT: Lista dei dispositivi per la stanza e la palestra selezionata
    #         Se il parametro firstMachine == 'None' allora ritorna una lista con tutti
    #         i dispositivi, se il parametro firstMachine è un deviceID, ritorna la
    #         lista di tutti i dispositivi accoppiabili priva del dispositivo indicato 
    #         dal deviceID passato in firstMachine

    # @Slot(str,str,str)
    # def pairList(self,gym,room,firstMachine):
    #     if firstMachine == 'None':
    #         #Return the whole available/pairable machine list
    #         pass
    #     else:
    #         #Return the whole listwithout available/pairable machine list
    #     self.devListSig.emit(deviceList)

    # OUTPUT: ritorna la lista dei dispositivi adiacenti al dispositivo indicato 
    # @Slot(str,str,str)
    # def getAdjacency(self,selectedGym,selectedRoom,selectedDevice):
    #     #Do processing and return adjList
    #     self.adjSig.emit(adjList)
        

    @Slot(str,str)
    def retrieveData(self,gym,room):
        # This function is called by the onClicked method of gym/room elements
        # If room is 'None', the click is coming from a gym element which request roomList
        # otherwise it is coming from a room element which request devList
        if gym == 'None' and room == 'None':
            self.context[room] = None
            self.context[gym] = None
            return
        if room == 'None':
            #load rooms
            #ENTERING CRITICAL SECTION, ADD LOCKS
            lista = list(self.dataStructure[gym].keys())
            r = []
            for room in lista:
                r.append({'name':room,'status':colConv(self.status[gym][room]['status'])})
            self.roomSig.emit(r)
            
            self.context['gym'] = gym
            self.context['room'] = None
            #RELEASE LOCK
        else:
            #load devices
            #ENTERING CRITICAL SECTION, ADD LOCKS
            #dList = [{'type':item['type'],'status':colConv(item['status'])} for item in self.dataStructure[gym][room]]
            self.devSig.emit([{'type':item['type'],'status':colConv(item['status'])} for item in self.dataStructure[gym][room].values()])
            self.context['gym'] = gym
            self.context['room'] = room
            #RELEASE LOCK 

    # BACK-END METHODS

    def sortData(self):
        #Sorting gyms
        for gym in self.dataStructure:
            self.dataStructure = {k: v for k, v in sorted(self.dataStructure.items(), key=lambda item: item[0])}
        # Sorting rooms
        for gym in self.dataStructure:
            for room in self.dataStructure[gym]:
                    self.dataStructure[gym] = {k: v for k, v in sorted(self.dataStructure[gym].items(), key=lambda item: item[0])}
        ##################################################
        # Sorting devices
        for gym in self.dataStructure:
            for room in self.dataStructure[gym]:
                self.dataStructure[gym][room] = {k: v for k, v in sorted(self.dataStructure[gym][room].items(), key=lambda item: item[0])}
                for idx,dev in enumerate(self.dataStructure[gym][room]):
                    self.dataStructure[gym][room][dev]['idx'] = idx 

    def updateStatus(self,activeDevices):
        totalSet = set()
        freshSet = set()

        freshSet.update([device['deviceID'] for device in activeDevices])
        ## replace with compact form
        for gym in self.dataStructure:
            for room in self.dataStructure[gym]:
                totalSet.update(list(self.dataStructure[gym][room]))
        # ############################################

        unavailableDev = totalSet.difference(freshSet)      
        
        if len(unavailableDev) == 0: 
            for gym in self.status:
                for room in self.status[gym]:
                    if room != 'status':
                        self.status[gym][room]['status'] = 0
                        if self.context['gym'] == gym:
                            self.updElem.emit({'model':2,'idx':list(self.dataStructure[gym]).index(room),'data':{'status':'green'}})

                    else:
                        self.status[gym]['status'] = 0
                        if self.context['gym'] != None:
                            self.updElem.emit({'model':1,'idx':list(self.dataStructure).index(gym),'data':{'status':'green'}})

            return
        
        faultSet = set()
        
        #SISTEMARE STA CAGATA
        for missingDev in unavailableDev:
            for gym in self.dataStructure:
                for room in self.dataStructure[gym]:
                    retVal = self.dataStructure[gym][room].get(missingDev,None)
                    if  retVal!= None:
                        self.dataStructure[gym][room][missingDev]['status'] = 3
                        faultSet.add(gym+'/'+room)
                        if self.context['gym'] == gym and self.context['room'] == room:
                            self.updElem.emit({'model':3,'idx':retVal['idx'],'data':{'status':'red'}}) #da usare con model.set()
        
        for item in faultSet:
            gym = item.split('/')[0]
            room = item.split('/')[1]
            self.status[gym]['status'] = 3
            self.status[gym][room]['status'] = 3
            self.updElem.emit({'model':1,'idx':list(self.dataStructure).index(gym),'data':{'status':'red'}})
            if self.context['gym'] == gym:
                self.updElem.emit({'model':2,'idx':list(self.dataStructure[gym]).index(room),'data':{'status':'red'}})
    
    @Slot(str)
    def updateContext(self,menu):
        self.context['menu'] = menu
    
    def updateData(self):
        # Retrieve active devices from device catalog
        try:
            devCat = requests.get(self.srvCat+'get/serviceID?serviceID=Device+Catalog').json()['url']
            activeDevices = requests.get(devCat+'get/deviceID').json()
        except:
            #self.connStatus.emit({'status':3,'description':'Connection Error'})
            return

        #self.connStatus.emit({'status':0,'description':'Connected'})
        
        # Set initially gym and room status to Fault, if the gym/room 
        # don't contains missing devices it will be updated in updateStatus() 
        for gym in self.status:
            for vGym in self.status[gym]:
                if vGym != 'status':
                    self.status[gym][vGym]['status'] = 3
                else:
                        self.status[gym]['status'] = 3

        if self.dataStructure != {}:
            if self.context['menu'] != 'home': self.updateFlag['gyms']=True
            self.updateStatus(activeDevices)

        for device in activeDevices:
            dGym = device['gymName']
            dRoom = device['roomName']
            dID = device['deviceID']
            
            #### TO BE REMOVED WHEN PEPPE SI SPICCIA #####
            if dID == 'M1': continue
            if dID == 'M2': continue
            if dID == 'M3': continue
            ##############################################
            gymVal = self.dataStructure.get(dGym,None)
            if gymVal == None: 
                self.status[dGym] = dict(status=0)
                self.dataStructure[dGym] = {}
                self.updateFlag['gyms'] = True

            roomVal = self.dataStructure[dGym].get(dRoom,None)
            if roomVal == None: 
                self.dataStructure[dGym][dRoom] = {}
                self.status[dGym][dRoom] = dict(status=0)
                if self.context['gym'] == dGym:
                    self.updateFlag['rooms'] = True

            devVal = self.dataStructure[dGym][dRoom].get(dID,None)
            
            if self.context['room'] == dRoom:
                if devVal == None:
                    self.updateFlag['devices'] = True
                else:
                    if devVal['status'] != 0:
                        self.updateFlag['devices'] = True

            self.dataStructure[dGym][dRoom][dID] = dict(type=device['type'],status=0,idx=None,description=device['description'],shordDesc=device['shortDesc'])
        #     self.dataStructure[dGym][dRoom][dID]['type'] = device['type']
        #     self.dataStructure[dGym][dRoom][dID]['status'] = 0
        #     self.dataStructure[dGym][dRoom][dID]['idx'] = None
        #     self.dataStructure[dGym][dRoom][dID]['description'] = device['description']
        #     self.dataStructure[dGym][dRoom][dID]['shortDesc'] = device['shortDesc']
        self.sortData()
        # Checks if during data visualization there was an update inherent to 
        # selected visualization and eventually update it
        if True in self.updateFlag.values():
            if self.updateFlag['gyms'] == True: 
                lista = list(self.dataStructure.keys())
                l = []
                for item in lista:
                    l.append({'name':item,'status':'green'})
                self.gymSig.emit(l)
                self.context['menu'] = 'home'
                self.updateFlag['gyms'] = False

            if self.updateFlag['rooms'] == True: 
                lista = list(self.dataStructure[self.context['gym']].keys())
                r = []
                for item in lista:
                    r.append({'name':item,'status':'green'})
                self.roomSig.emit(r)
                self.updateFlag['rooms'] = False

            if self.updateFlag['devices'] == True: 
                lista = list(self.dataStructure[self.context['gym']][self.context['room']].keys())
                r = []
                for item in lista:
                    r.append({'type':item,'status':'green'})
                self.devSig.emit(r)
                self.updateFlag['devices'] = False
                
    @Slot(str,str,str,str)
    def pairList(self,gym,room,m1,m2):
        print(f"Pair List: {gym} {room} {m1} {m2}")
    
    @Slot(str,str,str)
    def getAdjacency(self,selectedGym,selectedRoom,selectedDevice):
        print(f"getAdjacency:{selectedGym} {selectedRoom} {selectedDevice}")

    
    ###############################################
    ### QUESTO SLOT RICEVERA' IL JSON IN FORMATO 
    ### STRINGA.
    ###############################################
    @Slot(str)
    def conf_SRM(self,actionDict):
        print(json.loads(actionDict))
    


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    app.setOrganizationName('pythonProj')
    app.setOrganizationDomain('OD')
    # app.setWindowIcon(QIcon("images\od_conf.svg")) # convertire svg in pixmap
    # Get Context
    main = MainWindow()
    main.start_engine()

    # Set Context

    main.engine.rootContext().setContextProperty("backend", main)
    
    # Load QML file
    main.engine.load(os.fspath(Path(__file__).resolve().parent / "qml/main.qml"))
    
    
    if not main.engine.rootObjects():
        sys.exit(-1)
    
    
    sys.exit(app.exec_())
    
