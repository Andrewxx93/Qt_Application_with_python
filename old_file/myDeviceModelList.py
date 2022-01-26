from PySide2.QtCore import Slot, Signal, QAbstractListModel
from PySide2.QtCore import QModelIndex, Qt


class DeviceModelList(QAbstractListModel):
    TypeRole = Qt.UserRole + 1
    DeviceIdRole = Qt.UserRole + 2
    ShortDescriptionRole = Qt.UserRole + 3
    LongDescriptionRole = Qt.UserRole + 4
    StatusRole = Qt.UserRole + 5
    
    def __init__(self, gymName="",roomName="",deviceList=[], parent = None):
        super().__init__(parent)
        # Sostituire con lettura da file per leggere tutte le palestre presenti.
        #Definire gli stati della palestra e capire a chi bisogna chiedere
        self.devices =[]
        
        for device in deviceList:
            if(device["gymName"]==gymName and device["roomName"]==roomName):
                self.devices.append(dict(type=device["type"],deviceID=device["deviceID"],shortDescription=device["shortDesc"],longDescription = device["description"],status = "fulloperative"))
        self.devices.append(dict(type="+",deviceID="",shortDescription="",longDescription = "",status = "addDevice"))
        
        # self.devices = {}
        # self.row = 0;
        # for device in deviceList:
        #     if(device["gymName"]==gymName and device["roomName"]==roomName):
        #         self.devices[device["deviceID"]] = dict(type=device["type"],row=self.row,shortDescription=device["shortDesc"],longDescription = device["description"],status = "fulloperative")
        #         self.row +=1;
                
        # self.devicesKeysList = self.devices.keys()
        
        
        
    def data(self, index, role=Qt.DisplayRole):
        row = index.row()
        print(f"row = {row}, index = {index}")
        if role == DeviceModelList.TypeRole:
            return self.devices[row]["type"]
        if role == DeviceModelList.DeviceIdRole:
            return self.devices[row]["deviceID"]
        if role == DeviceModelList.ShortDescriptionRole:
            return self.devices[row]["shortDescription"]
        if role == DeviceModelList.LongDescriptionRole:
            return self.devices[row]["longDescription"]
        if role == DeviceModelList.StatusRole:
            return self.devices[row]["status"]
            
    def rowCount(self,parent=QModelIndex()):
        return len(self.devices)
    
    def roleNames(self):
        return{
            DeviceModelList.TypeRole: b'type',
            DeviceModelList.DeviceIdRole: b'deviceID',
            DeviceModelList.ShortDescriptionRole: b'shortDescription',
            DeviceModelList.LongDescriptionRole: b'longDescription',
            DeviceModelList.StatusRole: b"status"
        }
        
    
    #Bisogna aggiungere lo stato del singolo devi. A chi bisogra chiedere ? EntryControl ???
    @Slot(str)
    def addDevice(self,type,deviceID,shortDescription,longDescription,status):
        self.beginInsertRows(QModelIndex(), self.rowCount(), self.rowCount())
        self.devices.append(dict(type="+",deviceID="",shortDescription="",longDescription = "",status = "addDevice"))
        self.endInsertRows()
        
    def changeStatus(self,status,row):
        ix = self.index(row,0)
        self.devices[row]["status"] = status
        self.dataChanged.emit(ix,ix,self.roleNames())