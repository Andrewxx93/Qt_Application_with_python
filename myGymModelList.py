from PySide2.QtCore import Slot, Signal, QAbstractListModel
from PySide2.QtCore import QModelIndex, Qt



class GymModelList(QAbstractListModel):
    def __init__(self, parent = None):
        super().__init__(parent)
        # Sostituire con lettura da file per leggere tutte le palestre presenti
        self.gyms = [
            {"name": "San Salvario", "id": 1234},
            {"name": "Donato","id": 5678}
            ]
            
    def data(self, index, role=Qt.DisplayRole):
        row = index.row()
        if role == GymModelList.NameRole:
            return self.gyms[row]["name"]
        if role == GymModelList.IDRole:
            return self.gyms[row]["id"]
            
    def rowCount(self):
        return len(self.gyms)
    
    def roleNames(self):
        return{
            GymModelList.NameRole: b'name',
            GymModelList.IDRole: b'id'
        }
        
    @Slot(str,int)
    def addGym(self,name,id):
        self.beginInsertRows(QModelIndex(), self.rowCount(), self.rowCount())
        self.gyms.append({"name":name,"id":id})
        self.endInsertRows()