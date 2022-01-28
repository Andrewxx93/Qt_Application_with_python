# This Python file uses the following encoding: utf-8
import os
from pathlib import Path
import sys
import datetime
import json
import time
import threading

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QObject, Slot, Signal, QTimer, QUrl


class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)
        

        # QTimer - Run Timer
        self.timer = QTimer()
        self.timer.timeout.connect(lambda: self.setTime())
        self.timer.start(1000)
        
        
        self.l1 = [{"name":"San Donato","status":"green"},{"name":"San Salvario","status":"green"},{"name":"San Donato","status":"green"},{"name":"San Salvario","status":"green"},{"name":"San Donato","status":"green"},{"name":"San Salvario","status":"green"},{"name":"San Donato","status":"green"},{"name":"San Salvario","status":"green"},{"name":"San Donato","status":"green"},{"name":"San Salvario","status":"green"},{"name":"San Donato","status":"green"},{"name":"San Salvario","status":"green"},{"name":"San Donato","status":"green"},{"name":"San Salvario","status":"green"},{"name":"San Donato","status":"green"},{"name":"San Salvario","status":"green"},{"name":"San Donato","status":"green"},{"name":"San Salvario","status":"green"},{"name":"San Donato","status":"green"},{"name":"San Salvario","status":"green"}]
        self.l2 = [{"name":"spinnig","status":"blue"},{"name":"Cardio","status":"red"}]
        self.l2_bis = [{"name":"HIIT","status":"blue"},{"name":"Cavolo","status":"red"}]
        self.l3 = [{"type": "RFID","status":"green","shorDesc":"IN","description":"ingresso principale","idx":None}]
        self.dataStructure = {'San Donato': {'Spinning': {'TV_1': {'type': 'TV', 'status': 0, 'idx': None, 'description': 'TV ingresso sinistra', 'shortDesc': 'TV SX'}, 'TV_2': {'type': 'TV', 'status': 0, 'idx': None, 'description': 'TV in fondo a destra', 'shortDesc': 'TV DX'}, 'Light_1': {'type': 'Light', 'status': 0, 'idx': None, 'description': 'Linea luci principale', 'shortDesc': 'Luci Princ'}, 'Light_2': {'type': 'Light', 'status': 0, 'idx': None, 'description': 'Linea luci emergenza', 'shortDesc': 'Luci Eme'}, 'Audio_1': {'type': 'Audio', 'status': 0, 'idx': None, 'description': 'Sistema audio principale', 'shortDesc': 'Audio1'}, 'Video_1': {'type': 'Video', 'status': 0, 'idx': None, 'description': 'Sistema video principale', 'shortDesc': 'Video1'}, 'Spinbike_1': {'type': 'Spinbike', 'status': 0, 'idx': None, 'description': 'Spinbike number 1', 'shortDesc': 'Spin1'}, 'Spinbike_2': {'type': 'Spinbike', 'status': 0, 'idx': None, 'description': 'Spinbike number 2', 'shortDesc': 'Spin2'}, 'Spinbike_3': {'type': 'Spinbike', 'status': 0, 'idx': None, 'description': 'Spinbike number 3', 'shortDesc': 'Spin3'}, 'Spinbike_4': {'type': 'Spinbike', 'status': 0, 'idx': None, 'description': 'Spinbike number 4', 'shortDesc': 'Spin4'}, 'RFID_1': {'type': 'RFID', 'status': 0, 'idx': None, 'description': 'out', 'shortDesc': 'OUT'}, 'RFID_2': {'type': 'RFID', 'status': 0, 'idx': None, 'description': 'in', 'shortDesc': 'IN'}}}}
        
    # Ale signals
    
    gymSig = Signal(list)
    roomSig = Signal(list)
    deviceSig = Signal(list)
    
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
        #print(formatDate)
        self.printTime.emit(formatDate)

    # Function Set Name To Label

    @Slot(str)
    def welcomeText(self, name):
        if name != "":
            self.setName.emit("Welcome, " + name)
        else:
            self.setName.emit("Welcome")
    
    @Slot(str)
    def selectGym(self,gymName):
        print(gymName)
        
    @Slot()
    def loadGymsStartup(self):
        gymList = list(self.l1)
        self.gymSig.emit(gymList)
    
    
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


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    app.setOrganizationName('pythonProj')
    app.setOrganizationDomain('OD')
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
    
