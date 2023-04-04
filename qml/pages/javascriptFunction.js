    /*
    Questa funzione è da mettere in Connections{ target: backend} della pagina
    SRM; Bisogna creare il signal resetAllSig = Signal(int); in teoria, dopo che invii
    la configurazione allo SRM bisogna fare self.resetAllSig.emit(0) ma in pratica a me
    non funzionava; Se non funziona vai nel bottone sendConf e incollalo li dopo il backend.sendConf()
    e ciao ciao
    
    */
    
    
    function onResetAllSig(code){
            if(code ===0){
                print("Adesso spacco tutto")
                gymComboBox.currentIndex =-1
                roomComboBox.currentIndex = -1
                nameEventLessonText.text = ""
                setThresholdTextField.text = ""
                totalThresholdCustomField.text = ""
                scheduledListView.scheduledListModel.clear()
                configurationSRMModel.clear()
                gymName = ""
                roomName = ""

               scheduledDict = ({})

               for(var i=0; i<modelData.count; i++){
                    userListView.itemAtIndex(i).checked = false
                    ownerListView.itemAtIndex(i).checked = false
                    workerListView.itemAtIndex(i).checked = false
                    trainerListView.itemAtIndex(i).checked = false
                    schedulerDeviceSelectionListView.itemAtIndex(i).checked = false

                                }
                initActionDict()

            }
        }



/* 
Per quanto riguarda la parte di selezione delle macchine nella pagina Statistics o si riepe tutta la pagine con
il mini browser, oppure si lascia cosi com'è e si deve vedere come ottenere la pagina html di quella determinata macchina: 
credo si tratti di capire in quale canale vengono memorizzati tutti i dati di quella determinata maccchina e creare
l'url per ottenere la visualizzazione di solo quel grafico

*/