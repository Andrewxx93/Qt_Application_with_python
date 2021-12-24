# This Python file uses the following encoding: utf-8
import os
from pathlib import Path
import sys
import datetime
import json
import time

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QObject, Slot, Signal, QTimer, QUrl
from gymLoader import *

import myGymModelList as mg # model gym
import myRoomModelList as mr # model room
import myDeviceModelList as md # model device


    
class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)
        # self.addElementList()

        # QTimer - Run Timer
        self.timer = QTimer()
        self.timer.timeout.connect(lambda: self.setTime())
        self.timer.start(1000)
        
        # Gym creation
        #Inserire GET request al service catalog 
        with open("LISTfromDeviceCatalog.json") as fp:
            getResponse= json.load(fp)
        
        self.deviceList = getResponse["palestre"]    
        gymLoader = GymLoader(getResponse)

        self.gymList,self.rooms = gymLoader.loader()
    
        self.gymModelList = mg.GymModelList(self.gymList)
        
        
        # All'avvio nessuna palestra è selezionata quindi non bisogna visualizzare nessuna stanza e 
        # nessun dispositivo
        self.roomList = []
        self.roomModelList = mr.RoomModelList(self.roomList)
        
        self.gymName = ""
        self.deviceModelList = md.DeviceModelList()
        
        
        

        
    # Signal Set Name
    setName = Signal(str)

    # Signal Add elem
    addElem = Signal(dict)

    # Signal Set Data
    printTime = Signal(str)

    # Signal Visible
    isVisible = Signal(bool)

    # Signal Read Text
    readText = Signal(str)

    # Signal set Gym name
    setGymName = Signal(str)

    # Signal set Model in combobox
    setModel = Signal(list)

    # Text String
    textField = ""
    
    def start_engine(self):
        self.engine = QQmlApplicationEngine()

    # Open File
    @Slot(str)
    def openFile(self, filePath):
        file = open(QUrl(filePath).toLocalFile(), encoding="utf-8")
        text = file.read()
        file.close()
        print(text)
        self.readText.emit(str(text))

    # Read Text
    @Slot(str)
    def getTextField(self, text):
        self.textField = text

    # Write File
    @Slot(str)
    def writeFile(self, filePath):
        file = open(QUrl(filePath).toLocalFile(), "w")
        file.write(self.textField)
        file.close()
        print(self.textField)

    # Show / Hide Rectangle
    @Slot(bool)
    def showHideRectangle(self, isChecked):
        print(f"Is rectangle visible ?: {isChecked} ")
        self.isVisible.emit(isChecked)

    # Set Timer Function

    def setTime(self):
        now = datetime.datetime.now()
        formatDate = now.strftime("Now is %H:%M:%S of %Y/%m/%d")
        print(formatDate)
        self.printTime.emit(formatDate)

    # Function Set Name To Label

    @Slot(str)
    def welcomeText(self, name):
        if name != "":
            self.setName.emit("Welcome, " + name)
        else:
            self.setName.emit("Welcome")

    # This method select the gym and displays the room inside that specific gym. 
    @Slot(str)
    def selectGym(self,gymName):
        print(f"La palestra selezionata è:{gymName} ")
        self.roomList = []
        if gymName in self.gymList:
            self.gymName = gymName
            self.roomList = self.rooms[gymName]
            print(self.roomList)
            self.roomModelList = mr.RoomModelList(self.roomList)
            self.engine.rootContext().setContextProperty('roomModelList', self.roomModelList)
    
    
    # This method select the room and displays all the devices inside that specific room.   
    @Slot(str)
    def selectRoom(self,roomName):
        if self.gymName in self.gymList and roomName in self.roomList:
            print(f"Selected gym {self.gymName} room {roomName}")
            self.deviceModelList = md.DeviceModelList(self.gymName,roomName,self.deviceList)
            self.engine.rootContext().setContextProperty('deviceModelList', self.deviceModelList)
    
    @Slot(str)
    def addNewGym(self,gymName):
        self.gymModelList.changeStatus("closed", 1)
        self.gymModelList.changeStatus("problems", 0)
        print(f"Add new Gym: {gymName}")
        self.gymName = gymName
        self.roomList = []
        self.roomModelList = mr.RoomModelList(self.roomList)
        self.engine.rootContext().setContextProperty('roomModelList', self.roomModelList)
        # Ricordati di ricaricare self.engine.rootContext().setContextProperty("gymModelList",self.gymModelList)
        #In questo caso bisogna aggiornare la lista ritornata dal Device Catalog andando a chiedere di aggiornare la palestra e le stanze che ci sono
    

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


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    
    # Get Context
    main = MainWindow()
    main.start_engine()
    
    # Set Context
    main.engine.rootContext().setContextProperty("backend", main)
    main.engine.rootContext().setContextProperty('gymModelList', main.gymModelList)
    main.engine.rootContext().setContextProperty('roomModelList', main.roomModelList)
    main.engine.rootContext().setContextProperty('deviceModelList', main.deviceModelList)

    gymCount = main.gymModelList.rowCount()
    
    # Load QML file
    main.engine.load(os.fspath(Path(__file__).resolve().parent / "qml/main.qml"))

    
    

    if not main.engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
