# This Python file uses the following encoding: utf-8
import os
from pathlib import Path
import sys
import datetime

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QObject, Slot, Signal, QTimer, QUrl
from PySide2.QtWidgets import QComboBox


class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)

        # QTimer - Run Timer
        self.timer = QTimer()
        self.timer.timeout.connect(lambda: self.setTime())
        self.timer.start(1000)

        # Base JSON for Specific Room Management
        """ 
            creare JSON base da caricare
        """

    # Signal Set Name
    setName = Signal(str)

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

    @Slot(str, str, str)
    def jsonCreator(self, gymName, roomName1, roomName2):
        print(f"Gym name: {gymName}")
        print(f"Room1 name: {roomName1}")
        print(f"Room2 name: {roomName2}")
        # print(f"Current text in combobox: {currentText}")
        self.setGymName.emit("The Gym name is: " + gymName)
        if(gymName=='1'):
            self.setModel.emit(["primo","secondo","terzo","quarto"])   # Con questo si possono settare dinamicamente gli elementi dentro la ComboBox
        elif(gymName=='2'):
            self.setModel.emit(["uno","due","tre","quattro"])   # Con questo si possono settare dinamicamente gli elementi dentro la ComboBox


    


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    # Get Context
    main = MainWindow()
    engine.rootContext().setContextProperty("backend", main)

    # Load QML file
    engine.load(os.fspath(Path(__file__).resolve().parent / "qml/main.qml"))
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
