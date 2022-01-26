from PySide2.QtCore import Slot, Signal, QAbstractListModel
from PySide2.QtCore import QModelIndex, Qt



class RoomModelList(QAbstractListModel):
    NameRole = Qt.UserRole + 1
    StatusRole = Qt.UserRole + 2
    
    
    def __init__(self, roomList,parent = None):
        super().__init__(parent)
        # Sostituire con lettura da file per leggere tutte le palestre presenti.
        #Definire gli stati della palestra e capire a chi bisogna chiedere
        self.rooms = []
        for room in roomList:
            self.rooms.append(dict(name = room,status = "fulloperative"))
        self.rooms.append(dict(name="+",status = "addRoom"))
        # self.rooms = [  {"name": "room1", "id": 1234,"status": "Fulloperative"} ]
            
    def data(self, index, role=Qt.DisplayRole):
        row = index.row()
        print(f"row = {row}, index = {index}")
        if role == RoomModelList.NameRole:
            return self.rooms[row]["name"]
        if role == RoomModelList.StatusRole:
            return self.rooms[row]["status"]
            
    def rowCount(self,parent=QModelIndex()):
        return len(self.rooms)
    
    def roleNames(self):
        return{
            RoomModelList.NameRole: b'name',
            RoomModelList.StatusRole: b'status'
        }
        
        
    #Bisogna aggiungere lo stato della stanza. A chi bisogra chiedere ? EntryControl ???
    @Slot(str)
    def addRoom(self,name):
        self.beginInsertRows(QModelIndex(), self.rowCount(), self.rowCount())
        self.rooms.append({"name":name,"status": "fulloperative"})
        self.endInsertRows()
        
    def changeStatus(self,status,row):
        ix = self.index(row,0)
        self.rooms[row]["status"] = status
        self.dataChanged.emit(ix,ix,self.roleNames())