# This Python file uses the following encoding: utf-8
import os, threading, requests
from pathlib import Path
import sys
import datetime
import json
import time
import threading

from PySide2.QtGui import QGuiApplication, QIcon
from PySide2.QtWidgets import QApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QObject, Slot, Signal, QTimer, QUrl
from PySide2.QtWebEngine import QtWebEngine
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
    adjSig = Signal(list)
    connStatus = Signal('Qvariant')
    
    signalAle = Signal(int)
    removeConfSig = Signal(int)

    # Signal Set Data
    printTime = Signal(str)
    
    def start_engine(self):
        QtWebEngine.initialize()
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
        print("\n\n\nRetrive data!!!!\n\n\n")
        if gymName == 'None' and roomName == 'None':
            gymList = [{"name": "San Donato", "status": "green"}]
            self.gymSig.emit(gymList)
        if roomName == 'None':
            if gymName == "San Donato":
                roomList = [{"name": "Cazzo", "status": "green"}]
            else:
                roomList = [{"name": "Prova", "status": "red"}]
            self.roomSig.emit(roomList)
        else:
            deviceList = self.l3
            print(deviceList)
            self.deviceSig.emit(deviceList)
            
    @Slot(str)
    def receiveConfElem(self,actionDict):
        
        confElementDict = json.loads(actionDict)
        print(type(confElementDict))
        print(confElementDict)
        self.signalAle.emit(0)
        
    @Slot(str)
    def removeConf(self,confName):
        ######SE LA RIMOZIONE AVVIENE CON SUCCESSO FAI EMIT 0 ALTRIMENTI EMIT 1
        print(confName)
        self.removeConfSig.emit(0) #Se tutto ok
        
        #self.removeConfSig.emit(1) #Se qualcosa è andato storto

    @Slot()
    def sendConf(self):
        print("Invia conf dict allo SRM")
            

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

    resetAllSig = Signal(int)
    @Slot()
    def sendConf(self):
        self.resetAllSig.emit(0)
        
    
        
    


if __name__ == "__main__":
    app = QApplication(sys.argv)
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
    
