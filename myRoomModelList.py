from PySide2.QtCore import Slot, Signal, QAbstractListModel
from PySide2.QtCore import QModelIndex, Qt



class RoomModelList(QAbstractListModel):
    NameRole = Qt.UserRole + 1
    IDRole =Qt.UserRole + 2
    StatusRole = Qt.UserRole + 3
    
    def __init__(self, parent = None):
        super().__init__(parent)
        # Sostituire con lettura da file per leggere tutte le palestre presenti.
        #Definire gli stati della palestra e capire a chi bisogna chiedere
        self.rooms = [
            {"name": "room1", "id": 1234,"status": "Fulloperative"},
            {"name": "room2", "id": 1234,"status": "Fulloperative"},
            {"name": "room3", "id": 1234,"status": "Fulloperative"},
            {"name": "room4", "id": 1234,"status": "Fulloperative"},
            {"name": "room5", "id": 1234,"status": "Fulloperative"},
            {"name": "room6", "id": 1234,"status": "Fulloperative"},
            
            
            ]
            
    def data(self, index, role=Qt.DisplayRole):
        row = index.row()
        if role == RoomModelList.NameRole:
            return self.rooms[row]["name"]
        if role == RoomModelList.IDRole:
            return self.rooms[row]["id"]
        if role == RoomModelList.StatusRole:
            return self.rooms[row]["status"]
            
    def rowCount(self,parent=QModelIndex()):
        return len(self.rooms)
    
    def roleNames(self):
        return{
            RoomModelList.NameRole: b'name',
            RoomModelList.IDRole: b'id',
            RoomModelList.StatusRole: b'status'
        }
        
        
    #Bisogna aggiungere lo stato della palestra. A chi bisogra chiedere ? EntryControl ???
    @Slot(str,int)
    def addRoom(self,name,id):
        self.beginInsertRows(QModelIndex(), self.rowCount(), self.rowCount())
        self.rooms.append({"name":name,"id":id})
        self.endInsertRows()