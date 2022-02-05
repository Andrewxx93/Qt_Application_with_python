import paho.mqtt.client as PahoMQTT
import json 
class MyMQTT:
	def __init__(self, clientID, broker, port, notifier=None, quos=2, clearBuffer=True):
		self.broker = broker
		self.port = port
		self.notifier = notifier
		self.clientID = clientID
		#implements a list of possible topics for the class to be subscriber for
		self._topic = []
		#saves the Quality of Service for this client (both client and subscriber must use the same) 
		self._quos = quos
		self._isSubscriber = False 
		#clearbuffer is used to implement a durable connection
		self._paho_mqtt = PahoMQTT.Client(clientID, clearBuffer)
		self._paho_mqtt.on_connect = self.myOnConnect
		self._paho_mqtt.on_message = self.myOnMessageReceived
	def myOnConnect(self, paho_mqtt, userdata, flags, rc):
		print(f"connected to {self.broker}, with result code: {rc}")
	def myOnMessageReceived(self, paho_mqtt, userdata, msg):
		self.notifier.notify(msg.topic, msg.payload)
	def myPublish(self, topic, msg):
		print(f"publishing {msg} to topic {topic}")
		self._paho_mqtt.publish(topic, json.dumps(msg), self._quos)
	def mySubscribe(self, topic):
		print(f"subscribing to {topic}")
		self._paho_mqtt.subscribe(topic, self._quos)	
		if (not self._isSubscriber):
			self._isSubscriber=True
		self._topic.append(topic)
	def myGetTopics(self):
		#returns the list of topics
		return self._topic		
	def start(self):
		self._paho_mqtt.connect(self.broker, self.port)
		self._paho_mqtt.loop_start()
	def stop(self):
		if (self._isSubscriber):
			for i in range(self._topic):
				self._paho_mqtt.unsubscribe(self._topic[i])
		self._paho_mqtt.loop_stop()
		self._paho_mqtt.disconnect()
	def unsubscribe(self, topic):
		self._paho_mqtt.unsubscribe(topic)
		self._isSubscriber = False
	

