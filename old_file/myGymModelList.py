from PySide2.QtCore import Slot, Signal, QAbstractListModel
from PySide2.QtCore import QModelIndex, Qt


class GymModelList(QAbstractListModel):
    NameRole = Qt.UserRole + 1
    StatusRole = Qt.UserRole + 2

    def __init__(self, gymList, parent = None):
        super().__init__(parent)
        # Sostituire con lettura da file per leggere tutte le palestre presenti.
        #Definire gli stati della palestra e capire a chi bisogna chiedere
        self.gyms =[]
        self.convert = {}
        for gym in gymList:
            self.gyms.append(dict( name = gym, status="fulloperative"))
        self.gyms.append(dict(name="+",status = "addGym"))
        # self.row = 0
        # for gym in gymList:
        #     self.convert[self.row] = gym["deviceID"]
        #     self.row
            
    def data(self, index, role=Qt.DisplayRole):
        row = index.row()
        print(f"row = {row}, index = {index}")
        if role == GymModelList.NameRole:
            return self.gyms[row]["name"]
        if role == GymModelList.StatusRole:
            return self.gyms[row]["status"]


    def rowCount(self,parent=QModelIndex()):
        return len(self.gyms)

    def roleNames(self):
        return{
            GymModelList.NameRole: b'name',
            GymModelList.StatusRole: b'status',

        }



    #Bisogna aggiungere lo stato della palestra. A chi bisogra chiedere ? EntryControl ???
    @Slot(str)
    def addGym(self,name):
        self.beginInsertRows(QModelIndex(), self.rowCount(), self.rowCount())
        self.gyms.append({"name":name,"status": "problems"})
        self.endInsertRows()


    #Con row si seleziona la palestra che bisogna aggiornare !!!
    def changeStatus(self,status,row):
        ix = self.index(row,0)
        self.gyms[row]["status"] = status
        self.dataChanged.emit(ix,ix,self.roleNames())

