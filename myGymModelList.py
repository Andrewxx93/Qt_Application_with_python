from PySide2.QtCore import Slot, Signal, QAbstractListModel
from PySide2.QtCore import QModelIndex, Qt



class GymModelList(QAbstractListModel):
    NameRole = Qt.UserRole + 1
    IDRole =Qt.UserRole + 2
    StatusRole = Qt.UserRole + 3
    
    def __init__(self, parent = None):
        super().__init__(parent)
        # Sostituire con lettura da file per leggere tutte le palestre presenti.
        #Definire gli stati della palestra e capire a chi bisogna chiedere
        self.gyms = [
            {"name": "GYM1", "id": 1234,"status": "Fulloperative"},
            {"name": "GYM2", "id": 1234,"status": "Fulloperative"},
            {"name": "GYM3", "id": 1234,"status": "Fulloperative"},
            {"name": "GYM4", "id": 1234,"status": "Fulloperative"},
            {"name": "GYM5", "id": 1234,"status": "Fulloperative"},
            {"name": "GYM6", "id": 1234,"status": "Fulloperative"},
            {"name": "GYM7","id": 5678, "status": "Fulloperative"},
            {"name": "GYM8","id": 5678, "status": "Fulloperative"},
            {"name": "GYM9","id": 5678, "status": "Fulloperative"},
            {"name": "GYM10","id": 5678, "status": "Fulloperative"},
            {"name": "GYM11","id": 5678, "status": "Fulloperative"},
            {"name": "GYM12","id": 5678, "status": "Fulloperative"},
            {"name": "GYM13","id": 5678, "status": "Fulloperative"},
            {"name": "GYM14","id": 5678, "status": "Fulloperative"},
            
            ]
            
    def data(self, index, role=Qt.DisplayRole):
        row = index.row()
        if role == GymModelList.NameRole:
            return self.gyms[row]["name"]
        if role == GymModelList.IDRole:
            return self.gyms[row]["id"]
        if role == GymModelList.StatusRole:
            return self.gyms[row]["status"]
            
    def rowCount(self,parent=QModelIndex()):
        return len(self.gyms)
    
    def roleNames(self):
        return{
            GymModelList.NameRole: b'name',
            GymModelList.IDRole: b'id',
            GymModelList.StatusRole: b'status'
        }
        
        
    #Bisogna aggiungere lo stato della palestra. A chi bisogra chiedere ? EntryControl ???
    @Slot(str,int)
    def addGym(self,name,id):
        self.beginInsertRows(QModelIndex(), self.rowCount(), self.rowCount())
        self.gyms.append({"name":name,"id":id})
        self.endInsertRows()