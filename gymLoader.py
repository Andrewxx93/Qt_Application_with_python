import json
#import requests


class GymLoader():
    def __init__(self,getResponse):
        self.gyms = [] # Contiene la lista di tutte le palestre da creare
        self.rooms ={} # E' un dizionario dove ogni chiave corrisponde ad una palestra e il valore è una lista di stanze
        self.getResponse = getResponse
        
    def loader(self):
        # Questa funzione è responsabile per la creazione della lista di palestre e di stanze per ogni palestra
        # da passare per la creazione di gymListModel e roomListModel
    
        # #Inserire GET request al service catalog 

        # with open("LISTfromDeviceCatalog.json") as fp:
        #     getResponse= json.load(fp)
            
        deviceList = self.getResponse["palestre"]
        
        for device in deviceList:
            if device["gymName"] not in self.gyms:
                self.gyms.append(device["gymName"])
                self.rooms[device["gymName"]] = []
            if device["roomName"] not in self.rooms[device["gymName"]]:
                self.rooms[device["gymName"]].append(device["roomName"])
        
        # print(self.gyms)
        # print(self.rooms)       
        
        return self.gyms, self.rooms