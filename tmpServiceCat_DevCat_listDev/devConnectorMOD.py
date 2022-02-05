from myMQTT import *
import time
import json
import threading
import cherrypy
import requests
cherrypy.config.update({'server.socket_port': 50040})
class CustomError(Exception):
	def __init__(self, message):
		Exception.__init__(self)
		self.message = message

class Publisher_subscriber():
    exposed = True
    def __init__(self, clientID, broker, port):
        self.client=MyMQTT(clientID, broker, port,self)
        self.port=port
        self.broker=broker
        self.clientID=clientID
        self.deviceListLock = threading.Lock()
        self.deviceList = []
        
    def notify(self,topic,msg):
        r = json.loads(msg)
        for i in range(len(self.deviceList)):
            if self.deviceList[i]['topic'] == topic and self.deviceList['i']['type'] == 'slave':
                self.deviceList[i]['status'] == bool(msg)
                break
        
    def addDev(self,dat):
        data = json.loads(dat)
        try:
            for i in range(len(self.deviceList)):
                if self.deviceList[i]['deviceID'] == data['deviceID']:
                    raise CustomError
        except CustomError:
            print('deviceID not available\n')
            return
        
        #entering critical section
        self.deviceListLock.acquire()
        self.deviceList.append(data)
        #if data['type'] == 'slave':
        #    self.client.mySubscribe(data['topic'])
        self.deviceListLock.release()
        #exiting critical section
    
    def removeDev(self, data):
        for i in range(len(self.deviceList)):
            if self.deviceList[i]['deviceID'] == data['deviceID']:
                #entering critical section
                self.deviceListLock.acquire()
                self.deviceList.pop(i)
                if(data['type']=='slave'):
                    self.client.unsubscribe(data['topic'])
                self.deviceListLock.release()
                #exiting critical section  
                break
    
    #def setValue(self, value,i):
    #    d = {"value": value, "id": self.clientID, "time": time.time()}
    #    self.client.myPublish(self.deviceList[i]['topic'], d)
    def dataIncoming(self,dat):
        #FORMAT: {"bn":"deviceID", "e": [{"value":"data", "time":"1234567"}]}
        print(dat)
        data = json.loads(dat)
        for i in range(len(self.deviceList)):
            if self.deviceList[i]['deviceID'] == data['bn']:
                self.client.myPublish(self.deviceList[i]['topic'], data)
                break
            
    def PUT(self, *uri, **param):
        payload = json.loads(cherrypy.request.body.read())
        with open('dataBus.txt', 'a+') as fp:
            json.dump(payload, fp, indent = 4)
            fp.close

    
    def start(self):
        self.client.start()
    def stop(self):
        self.client.stop()
    
class RegistrationThread(threading.Thread):
    def __init__(self, serviceCatalogUrl, client):
        threading.Thread.__init__(self)
        self.serviceCatalogUrl = serviceCatalogUrl
        self.deviceClient = client
    def run(self):
        while True:
            time.sleep(10)
            #find device Catalog
            r = requests.get(self.serviceCatalogUrl+'get/serviceID?serviceID=Device+Catalog')
            #print(f'{r.text}')
            deviceCatalog = json.loads(r.text)
            #enter critical section
            self.deviceClient.deviceListLock.acquire()

            for i in range(len(self.deviceClient.deviceList)):
                r = requests.put(deviceCatalog['url']+'add/deviceID', data = json.dumps(self.deviceClient.deviceList[i]))

            self.deviceClient.deviceListLock.release()
            #exit critical section
class inputThread(threading.Thread):
    def __init__(self, client):
        threading.Thread.__init__(self)
        self.client = client
        self.menu = dict(a = client.addDev, r = client.removeDev, d = client.dataIncoming)
    def run(self):
        while True:
                req = input('a-insert device\nr-remove device\nd-incoming data')
                if req[0] == 'A':
                    x = open('spinningSetup.txt','r').readlines()
                    for item in x:
                        stringa = item.rstrip("'\n'")
                        print(stringa)
                        jstringa = json.loads(stringa)
                        type(jstringa)    
                        self.menu['a'](stringa)
                    continue
                self.menu[req[0]](req[1::])

if __name__=='__main__':
    serviceCatalogUrl = 'http://127.0.0.1:8080/'
    r = requests.get(serviceCatalogUrl+'get/broker')
    config = json.loads(r.text)
    client = Publisher_subscriber( 'client1', config['broker'], config['port'])
    thread1 = RegistrationThread(serviceCatalogUrl, client)
    thread2 = inputThread(client)
    conf = {
		'/':{
				'request.dispatch': cherrypy.dispatch.MethodDispatcher(),
				'tool.session.on': True
		}
	}
    cherrypy.tree.mount(client,'/', conf)
    cherrypy.engine.start()
    thread1.start()
    thread2.start()
    client.start()
    cherrypy.engine.block()


