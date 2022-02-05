import cherrypy
import time 
import json
import threading
import os
import requests
cherrypy.config.update({'server.socket_port': 50000})
class CustomError(Exception):
	def __init__(self, message):
		Exception.__init__(self)
		self.message = message

class OnlineCatalog():
	exposed = True
	def __init__(self, catalogID, broker, port, lock):
		self.catalogID = catalogID
		self.deviceList = []
		self.menuGET = {'get deviceID': self.getDevice}
		self.menuPUTPOST = {'add deviceID': self.addDevice }
		self.broker = { 'broker': broker, 'port': port }
		self.deviceListLock=lock
	
	def GET (self, *uri, **param):
		res = list(uri)
		command = ' '.join(uri)
		try:
			output = self.menuGET[command](list(param.values())[0])
		except KeyError:
			output = 'Wrong request'
		except IndexError:
			output = self.menuGET[command]()
		return output 
	def POST (self, *uri, **param):
		es = list(uri)
		command = ' '.join(uri)
		payload = json.loads(cherrypy.request.body.read())
		try:
			output = self.menuPUTPOST[command](payload, True)
		except KeyError:
			output = 'Wrong request'
		except CustomError as error:
			output = error.message
		return output

	def PUT (self, *uri, **param):
		res = list(uri)
		command = ' '.join(uri)
		payload = json.loads(cherrypy.request.body.read())
		try:
			output = self.menuPUTPOST[command](payload, False)
		except KeyError:
			output = 'Wrong request'
		return output 
	

	def getDevice(self, deviceID = None):
		found = 'deviceID not found'
		## entering critical section
		self.deviceListLock.acquire()
		if deviceID != None:
			for i in range(len(self.deviceList)):
				if self.deviceList[i]['deviceID'] == deviceID:
					found = json.dumps(self.deviceList[i], indent = 4)
		else:
			found = json.dumps(self.deviceList, indent = 4)
		self.deviceListLock.release()
		## exiting critical section
		return found


	
	def addDevice(self, *data):
		deviceData = data[0]
		isPOST = data[1]
		deviceData['insert-timestamp'] = time.time()
		output = 'Device added'
		## entering critical section
		self.deviceListLock.acquire()
		for i in range(len(self.deviceList)):
			if self.deviceList[i]['deviceID'] == deviceData['deviceID']:
				if isPOST:
					raise CustomError('DeviceID is not available')
				else:
					self.deviceList.pop(i)
					output = 'Device found and updated'
					break
		self.deviceList.append(deviceData)
		self.deviceListLock.release()
		## exiting critical section
		return output	





class RefreshThread(threading.Thread):
	def __init__(self, threadID, deviceListLock):
		threading.Thread.__init__(self)
		self.threadID = threadID
		self.deviceListLock = deviceListLock
	def run(self):
		while True:
			time.sleep(20)
		## entering critical section
			self.deviceListLock.acquire()
			catalog.deviceList = [item for item in catalog.deviceList if time.time()-item['insert-timestamp'] <= 20]
			print(f'{json.dumps(catalog.deviceList, indent = 4)}')
			self.deviceListLock.release()
		## exiting critical section

class RegistrationThread(threading.Thread):
    def __init__(self, threadID, serviceCatalogUrl, deviceCatalogUrl):
        threading.Thread.__init__(self)
        self.threadID = threadID
        self.serviceCatalogUrl = serviceCatalogUrl
        self.catalogInformation = dict(serviceID='Device Catalog', url= deviceCatalogUrl)
    def run(self):
        while True:
            time.sleep(5)
            try:
                r = requests.put(self.serviceCatalogUrl + 'register serviceID', data = json.dumps(self.catalogInformation) )
                r.raise_for_status()
            except http_error:
                print('No Service Catalog connection')
                break

if __name__=='__main__':
	serviceCatalogUrl = 'http://127.0.0.1:8080/'
	r = requests.get(serviceCatalogUrl+"get broker")
	config = json.loads(r.text)
	deviceListLock = threading.Lock()
	thread1 = RefreshThread('thread1', deviceListLock)
	thread2 = RegistrationThread('thread2', serviceCatalogUrl,'http://127.0.0.1:50000/' )
	catalog = OnlineCatalog(config['broker'], config['port'], 'catalog1', deviceListLock)
	conf = {
		'/':{
				'request.dispatch': cherrypy.dispatch.MethodDispatcher(),
				'tools.sessions.on': True,
                'server.socket_port': 50000
		}
	}
	cherrypy.tree.mount(catalog,'/', conf)
	cherrypy.engine.start()
	thread1.start()
	thread2.start()
	cherrypy.engine.block()
	