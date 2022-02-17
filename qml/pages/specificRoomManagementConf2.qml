import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.15
import QtQuick.Dialogs 1.2
import "../controls"



Item {
    property string gymName: ""
    property string roomName: ""
    property string confName: ""
    property string threshold: ""   //for each entry of the scheduledDict
    property string totalThreshold: "" //for the global confDict
    property var scheduledDict: ({})
    property var actionDict: {"0":{},"1":{},"2":{},"3":{}}
    property var elemConfDict: ({})
    property int removeError: 0

//    width: 1400
//    height: 1000
    visible: true
    MessageDialog {
        id: duplicatedConfNameMessage
        title: "ERROR"
        text: "CONFIGURATION NAME ALREADY PRESENT"
        onAccepted: {
            console.log("Change configuration name")
            nameEventLessonText.errorCode = 1

        }

    }
    Rectangle {
        id: rectangle
        anchors.fill:parent
        color: "#ffffff"

        ScrollView{
            anchors.fill: parent
            clip: true
            contentHeight: 1000
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            Rectangle {
                id: contentFrame
                color: "#2c313c"
                anchors.fill: parent
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0

                Rectangle {
                    id: actionEventRect
                    color: "#00ffffff"
                    border.color: "#00ffffff"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.leftMargin: 0
                    anchors.topMargin: 0
                    clip: false
                    anchors.rightMargin: 0
                    height: 280


                    ListModel{
                        id: modelData
                        ListElement{
                            name : 'primo'
                        }
                        ListElement{
                            name : 'secondo'
                        }
                        ListElement{
                            name : 'terzo'
                        }

                    }

                    Component.onCompleted: {

                        initActionDict();

                    }

                    Label{
                        id: actionEventLabel
                        height: 40
                        color: "#ffffff"
                        text: qsTr("Action Event Selection")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                        font.pointSize: 12
                        anchors.rightMargin: 0
                        anchors.leftMargin: 20
                        anchors.topMargin: 10

                    }

                    RowLayout {
                        id: rowLayoutActionEvent
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: actionEventLabel.bottom
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0
                        anchors.rightMargin: 0
                        anchors.leftMargin: 10
                        anchors.topMargin: 10


                        Rectangle {
                            id: gymRoomSelectionRect
                            color: "#00ffffff"
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Layout.preferredWidth: 100
                            Layout.maximumWidth: 200


                            ColumnLayout {
                                id: rowLayoutAdjacentSelection

                                anchors.left: parent.left

                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.leftMargin: 20
                                antialiasing: true
                                anchors.rightMargin: 20
                                anchors.bottomMargin: 10
                                anchors.topMargin: 0

                                // gyms model list loading at startup
                                Component.onCompleted: {
                                    backend.getAdjacency('None','None','None')
                                }


                                ListModel{
                                    id: gymModelList
                                    //                                ListElement{
                                    //                                    name: "Crocetta"
                                    //                                }
                                    //                                ListElement{
                                    //                                    name: "Salvario"
                                    //                                }
                                    //                                ListElement{
                                    //                                    name: "Donato"
                                    //                                }


                                }
                                ListModel{
                                    id: roomModelList
                                    //                                ListElement{
                                    //                                    name: "Cardio"
                                    //                                }
                                    //                                ListElement{
                                    //                                    name: "Tapis"
                                    //                                }
                                    //                                ListElement{
                                    //                                    name: "Spinning"
                                    //                                }

                                }


                                Rectangle {
                                    id: rectangleGym
                                    color: "#00ffffff"
                                    Layout.leftMargin: 0
                                    clip: true
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.minimumHeight: 50


                                    Label{
                                        id: labelGymSelection
                                        color: "#ffffff"
                                        text : "GYM"
                                        anchors.top: parent.top
                                        anchors.topMargin: 0

                                    }
                                    CustomComboBox{
                                        id: gymComboBox
                                        anchors.top: labelGymSelection.bottom
                                        anchors.topMargin:10
                                        model: gymModelList
                                        implicitWidth: parent.width
                                        implicitHeight: 30
                                        //In order to display the text on the ComboBox when selected
                                        currentIndex: -1
                                        textRole: 'name'
                                        displayText: currentText

                                        delegate: ItemDelegate {

                                            contentItem: Text {
                                                text : name
                                                color: "#ffffff"
                                                elide: Text.ElideRight
                                                verticalAlignment: Text.AlignVCenter

                                            }
                                            onPressed: {
                                                gymName = name
                                                backend.getAdjacency( gymName,'None','None')

                                            }



                                        }


                                    }
                                }


                                Rectangle {
                                    id: rectangleRoom
                                    width: CustomComboBox.width

                                    color: "#00ffffff"
                                    clip: true
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.minimumHeight: 50
                                    Label {
                                        id: labelRoomSelection
                                        color: "#feffff"
                                        text: "ROOM"
                                        anchors.top: parent.top
                                        anchors.topMargin: 0


                                    }

                                    CustomComboBox {
                                        id: roomComboBox
                                        anchors.top: labelRoomSelection.bottom
                                        anchors.topMargin: 10
                                        model: roomModelList
                                        implicitWidth: parent.width
                                        implicitHeight: 30
                                        //In order to display the text on the ComboBox when selected
                                        currentIndex: -1
                                        textRole: 'name'
                                        displayText: currentText
                                        delegate: ItemDelegate {

                                            contentItem: Text {
                                                text: name
                                                color: "#ffffff"

                                            }
                                            onPressed: {
                                                roomName = name

                                            }
                                        }

                                    }
                                }

                                Rectangle {
                                    id: rectangleThreshold
                                    color: "#00ffffff"
                                    Layout.leftMargin: 0
                                    clip: true
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.minimumHeight: 50


                                    Label{
                                        id: labelThresholdSelection
                                        color: "#ffffff"
                                        text : "TOTAL THRESHOLD"
                                        anchors.top: parent.top
                                        anchors.topMargin: 0

                                    }
                                    CustomTextField{
                                        id: totalThresholdCustomField
                                        width: parent.width
                                        height: 30
                                        anchors.top: labelThresholdSelection.bottom
                                        anchors.topMargin: 10
                                        placeholderText: "Enter Threshold"
                                        validator: IntValidator{
                                            bottom: 0
                                        }
                                        onEditingFinished: totalThreshold = totalThresholdCustomField.text


                                    }

                                }



                            }



                        }

                        Rectangle {
                            id: userRect
                            width: 200

                            color: "#00d55b5b"
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Layout.preferredWidth: 100
                            Layout.maximumWidth: 200

                            Label{
                                id: userLabel
                                height: 20
                                color: "#ffffff"
                                text: "USER"
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                horizontalAlignment: Text.AlignLeft
                                verticalAlignment: Text.AlignVCenter
                                font.bold: false
                                font.pointSize: 8
                                anchors.rightMargin: 0
                                anchors.leftMargin: 45
                                anchors.topMargin: 0

                            }

                            ListView {
                                id: userListView
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: userLabel.bottom
                                anchors.bottom: parent.bottom
                                clip: true
                                anchors.leftMargin: 10
                                anchors.topMargin: 10
                                model: modelData
                                flickableDirection: Flickable.VerticalFlick
                                boundsBehavior: Flickable.StopAtBounds
                                ScrollBar.vertical: ScrollBar {}

                                delegate: CheckDelegate{
                                    id: userCheckDelegate
                                    contentItem: Text{
                                        text: modelData
                                        color: "#ffffff"

                                    }


                                    implicitHeight: 25

                                    indicator.x : 10
                                    indicator.width: 15
                                    indicator.height: 15
                                    leftPadding: 35
                                    topPadding: 0

                                    onClicked: {
                                        //                                    console.log(text)
                                        actionDict["0"][contentItem.text] =  userCheckDelegate.checked
                                        console.log( JSON.stringify(actionDict))

                                    }


                                }


                            }

                        }  //User Rect End


                        Rectangle {
                            id: ownerRect
                            width: 200
                            height: 200
                            color: "#00ffffff"
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Layout.preferredWidth: 100
                            Layout.maximumWidth: 200
                            Label {
                                id: ownerLabel
                                height: 20
                                color: "#ffffff"
                                text: "OWNER"
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                horizontalAlignment: Text.AlignLeft
                                verticalAlignment: Text.AlignVCenter
                                anchors.topMargin: 0
                                font.pointSize: 8
                                font.bold: false
                                anchors.leftMargin: 45
                                anchors.rightMargin: 0
                            }

                            ListView {
                                id: ownerListView
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: ownerLabel.bottom
                                anchors.bottom: parent.bottom
                                clip: true
                                model: modelData
                                anchors.topMargin: 10
                                anchors.leftMargin: 10
                                flickableDirection: Flickable.VerticalFlick
                                boundsBehavior: Flickable.StopAtBounds
                                ScrollBar.vertical: ScrollBar {}

                                delegate: CheckDelegate {
                                    id: ownerCheckDelegate
                                    contentItem: Text{
                                        text: modelData
                                        color: "#ffffff"

                                    }
                                    topPadding: 0
                                    indicator.x: 10
                                    indicator.width: 15
                                    indicator.height: 15
                                    leftPadding: 35
                                    implicitHeight: 25
                                    onClicked: {
                                        //                                    console.log(text)
                                        actionDict["1"][contentItem.text] =  ownerCheckDelegate.checked
                                        //                                    console.log( JSON.stringify(actionDict))

                                    }

                                }
                            }  //Owner Rect end

                        }
                        Rectangle {
                            id: workerRect
                            width: 200
                            height: 200
                            color: "#00ffffff"
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Layout.preferredWidth: 100
                            Layout.maximumWidth: 200
                            Label {
                                id: workerLabel
                                height: 20
                                color: "#ffffff"
                                text: "WORKER"
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                horizontalAlignment: Text.AlignLeft
                                verticalAlignment: Text.AlignVCenter
                                anchors.topMargin: 0
                                font.pointSize: 8
                                font.bold: false
                                anchors.leftMargin: 45
                                anchors.rightMargin: 0
                            }

                            ListView {
                                id: workerListView
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: workerLabel.bottom
                                anchors.bottom: parent.bottom
                                clip: true
                                model: modelData
                                anchors.topMargin: 10
                                anchors.leftMargin: 10
                                flickableDirection: Flickable.VerticalFlick
                                boundsBehavior: Flickable.StopAtBounds
                                ScrollBar.vertical: ScrollBar {}

                                delegate: CheckDelegate {
                                    id: workerCheckDelegate
                                    contentItem: Text{
                                        text: modelData
                                        color: "#ffffff"

                                    }
                                    topPadding: 0
                                    indicator.x: 10
                                    indicator.width: 15
                                    indicator.height: 15
                                    leftPadding: 35
                                    implicitHeight: 25
                                    onClicked: {
                                        //                                    console.log(text)
                                        actionDict["2"][contentItem.text] =  workerCheckDelegate.checked
                                        //                                    console.log( JSON.stringify(actionDict))


                                    }

                                }
                            }

                        }  //Worker Rect End

                        Rectangle {
                            id: trainerRect
                            width: 200
                            height: 200
                            color: "#00ffffff"
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Layout.preferredWidth: 100
                            Layout.maximumWidth: 200
                            Label {
                                id: trainerLabel
                                height: 20
                                color: "#ffffff"
                                text: "TRAINER"
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                horizontalAlignment: Text.AlignLeft
                                verticalAlignment: Text.AlignVCenter
                                anchors.topMargin: 0
                                font.pointSize: 8
                                font.bold: false
                                anchors.leftMargin: 45
                                anchors.rightMargin: 0
                            }

                            ListView {
                                id: trainerListView
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: trainerLabel.bottom
                                anchors.bottom: parent.bottom
                                clip: true
                                model: modelData
                                anchors.topMargin: 10
                                anchors.leftMargin: 10

                                flickableDirection: Flickable.VerticalFlick
                                boundsBehavior: Flickable.StopAtBounds
                                ScrollBar.vertical: ScrollBar {}

                                delegate: CheckDelegate {
                                    id: trainerCheckDelegate
                                    contentItem: Text{
                                        text: modelData
                                        color: "#ffffff"

                                    }
                                    topPadding: 0
                                    indicator.x: 10
                                    indicator.width: 15
                                    indicator.height: 15
                                    leftPadding: 35
                                    implicitHeight: 25
                                    onClicked: {
                                        //                                    console.log(text)
                                        actionDict["3"][contentItem.text] =  trainerCheckDelegate.checked
                                        //                                    console.log( JSON.stringify(actionDict))


                                    }

                                }
                            }

                        }  //Trainer Rect end

                    } //RowLayout End

                } //Action Rect End

                Rectangle {
                    id: schedulerRect
                    width: 550
                    color: "#00e12c2c"
                    border.color: "#00ffffff"
                    anchors.left: parent.left
                    anchors.top: actionEventRect.bottom
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                    anchors.topMargin: 20


                    Rectangle {
                        id: schedulerFrame
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0
                        anchors.rightMargin: 0
                        anchors.leftMargin: 20
                        anchors.topMargin: 0
                        color: "#00ffffff"

                        Label {
                            id: schedulerLabel

                            height: 40
                            color: "#ffffff"
                            text: qsTr("Event-Lesson Configuration")
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            verticalAlignment: Text.AlignVCenter
                            anchors.leftMargin: 0
                            font.bold: true
                            font.pointSize: 12
                            anchors.topMargin: 10
                            anchors.rightMargin: 0
                        }
                        Rectangle {
                            id: eventLessonSelectionRect
                            x: 8
                            width: parent.width
                            height: 40
                            color: "#00ffffff"
                            anchors.left: parent.left
                            anchors.top: schedulerLabel.bottom
                            anchors.leftMargin: 0
                            anchors.topMargin: 20

                            Rectangle {
                                id: addLessonRect
                                width: 100

                                color: "#00ffffff"
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 0
                                anchors.leftMargin: 0
                                anchors.topMargin: 0
                                Layout.maximumWidth: 70
                                Layout.preferredWidth: 50
                                Layout.fillHeight: true
                                Layout.fillWidth: true

                                CustomButton {
                                    id: addLessonButton

                                    text: "Add Lesson"
                                    anchors.fill: parent
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    enabled: if(nameEventLessonText.text.length===0){
                                                 return false
                                             }else{
                                                 return true
                                             }

                                    onClicked: {

                                        scheduledListView.scheduledListModel.append({ "name": nameEventLessonText.text, "number": 50,type:"Lesson",setFinishTimeVisibility:true})


                                    }
                                }
                            }

                            Rectangle {
                                id: addEventRect
                                width: 100

                                color: "#00ffffff"
                                anchors.left: addLessonRect.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 0
                                anchors.leftMargin: 10
                                anchors.topMargin: 0
                                Layout.maximumWidth: 70
                                Layout.preferredWidth: 50
                                Layout.fillHeight: true
                                Layout.fillWidth: true

                                CustomButton {
                                    id: addEventButton

                                    text: "Add Event"
                                    anchors.fill: parent

                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    enabled: if(nameEventLessonText.text.length===0){
                                                 return false
                                             }else{
                                                 return true
                                             }

                                    onClicked: {


                                        scheduledListView.scheduledListModel.append({ "name": nameEventLessonText.text, "number": 50,type:"Event",setFinishTimeVisibility:false})

                                    }

                                }
                            }

                            Rectangle {
                                id: nameEventLessonRect

                                color: "#00ffffff"
                                anchors.left: addEventRect.right
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                anchors.rightMargin: 0
                                anchors.leftMargin: 20
                                anchors.bottomMargin: 0
                                anchors.topMargin: 0
                                Layout.maximumWidth: 200
                                Layout.preferredWidth: 100
                                Layout.fillHeight: true
                                Layout.fillWidth: true

                                CustomTextField{
                                    id: nameEventLessonText
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    placeholderText: "Add Configuration Name"
                                    onEditingFinished: confName=nameEventLessonText.text

                                }
                            }

                        }
                        Rectangle {
                            id: schedulerSelectionRect
                            width: parent.width
                            height: 450
                            color: "#000000ff"

                            anchors.left: parent.left
                            anchors.top: eventLessonSelectionRect.bottom
                            anchors.leftMargin: 0
                            anchors.topMargin: 10


                            ListView{
                                id: scheduledListView
                                property ListModel scheduledListModel: ListModel{
                                    id: listModel;
                                    //                            ListElement{name: "Spinning-1 ";type:"Event";number: 20; setFinishTimeVisibility: true}
                                    //                            ListElement{name: "Spinning-1";type:"Lesson";number:10; setFinishTimeVisibility: false}
                                }
                                height: parent.height
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top

                                clip: true
                                model: listModel
                                spacing: 10
                                delegate:
                                    Item{
                                    id: delegateRect
                                    height: 60
                                    property string startTime: startTimePicker.timeValue
                                    property string finishTime: finishTimePicker.timeValue
                                    property string selectedData: ""
                                    property string dayDataName: ""

                                    property string activeMachines: ""
                                    property string confType: type
                                    //                                property string confName: name
                                    //                                property int threshold: parseInt(setThresholdTextField.text)
                                    //                                property string threshold: ""

                                    RowLayout{
                                        height: 60
                                        width: scheduledListView.width

                                        clip: true
                                        Rectangle{
                                            id: calendarRect
                                            color: "#ff0000"
                                            border.color: "#fb1515"
                                            Layout.maximumWidth: 100
                                            Layout.preferredHeight: 40
                                            Layout.preferredWidth: 100
                                            Layout.fillHeight: true
                                            Layout.fillWidth: true

                                            Label{
                                                id: calendarRectText
                                                text: "Selected Date"
                                                color: "#000000"

                                            }
                                            MouseArea{
                                                anchors.fill:parent
                                                onClicked: datePopup.open()

                                            }

                                            Popup{
                                                id: datePopup
                                                closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
                                                Rectangle{
                                                    width: 200
                                                    height: 200
                                                    color: "#ffffff"
                                                    x: -10
                                                    y: -200
                                                    CustomDatePicker{
                                                        id: datePicker

                                                        anchors.fill: parent

                                                        Component.onCompleted: set(new Date()) // today
                                                        onClicked:{

                                                            calendarRectText.text = qsTr(Qt.formatDate(date, 'd/M/yyyy'))
                                                            delegateRect.selectedData = qsTr(Qt.formatDate(date, 'd/M/yyyy'))
                                                            delegateRect.dayDataName = getSelectedDay()
                                                            datePopup.close()

                                                            //calendarRectText.dayName = getSelectedDay()
                                                            //                                                        print("Il giorno scelto e' : ",calendarRectText.dayName)
                                                            //                                                        print('onClicked', delegateRect.selectedData)



                                                        }
                                                    }
                                                }
                                            } // end Popup


                                        }

                                        Rectangle{
                                            id: startLessonRect
                                            color: "#00ffffff"
                                            Layout.maximumWidth: 140
                                            Layout.preferredHeight: 40
                                            Layout.minimumWidth: 60
                                            Layout.preferredWidth: 120
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true


                                            Rectangle{
                                                id: startLessonLabelRect
                                                height: 20
                                                color: "#0000ffff"
                                                anchors.left: parent.left
                                                anchors.right: parent.right
                                                anchors.top: parent.top
                                                anchors.rightMargin: 0
                                                anchors.leftMargin: 0
                                                anchors.topMargin: 0
                                                Label {
                                                    text: qsTr("Start: ") + confName ;
                                                    anchors.fill: parent
                                                    color: "#ffffff"

                                                }

                                            }
                                            Rectangle{
                                                anchors.left: parent.left
                                                anchors.right: parent.right
                                                anchors.top: startLessonLabelRect.bottom
                                                anchors.bottom: parent.bottom
                                                anchors.rightMargin: 0
                                                anchors.leftMargin: 0
                                                anchors.bottomMargin: 0
                                                color: "#00ffffff"
                                                CustomTimePicker{
                                                    id: startTimePicker
                                                    anchors.fill: parent

                                                }
                                            }


                                        }
                                        Rectangle{
                                            id: finishLessonRect
                                            Layout.maximumWidth: 140
                                            Layout.preferredHeight: 40
                                            Layout.minimumWidth: 60
                                            Layout.preferredWidth: 120
                                            Layout.fillHeight: true
                                            Layout.fillWidth: true
                                            color: "#00ffffff"

                                            Rectangle{
                                                id: finishLessonLabelRect
                                                width: parent.width
                                                height: 20
                                                color: "#00ffffff"
                                                visible: setFinishTimeVisibility   //If it is an event, only the start time picker is visible
                                                Label {
                                                    color: "#ffffff"
                                                    text: qsTr("Finish: ") + confName

                                                }


                                            }
                                            Rectangle{
                                                anchors.left: parent.left
                                                anchors.right: parent.right
                                                anchors.top: finishLessonLabelRect.bottom
                                                anchors.bottom: parent.bottom
                                                anchors.bottomMargin: 0
                                                anchors.rightMargin: 0
                                                anchors.leftMargin: 0
                                                anchors.topMargin: 0
                                                color: "#00ffffff"
                                                CustomTimePicker{
                                                    id: finishTimePicker
                                                    visible:  setFinishTimeVisibility
                                                    anchors.fill: parent
                                                }
                                            }




                                        }
                                        Rectangle{
                                            id: removeListElementButton

                                            color: "#00ffffff"
                                            Layout.preferredHeight: 30
                                            Layout.minimumHeight: 30
                                            Layout.maximumHeight: 30
                                            Layout.maximumWidth: 30
                                            Layout.minimumWidth: 30
                                            Layout.preferredWidth: 30
                                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                                            Layout.fillHeight: true
                                            Layout.fillWidth: true
                                            CustomRemoveButton{
                                                id: rmvButton
                                                text: qsTr("X")
                                                anchors.fill: parent
                                                onClicked: {

                                                    scheduledListView.scheduledListModel.remove(index)

                                                }
                                            }
                                        }

                                    }

                                }

                            } //End ListView



                        }
                    }

                }

                Rectangle {
                    id: configurationRect

                    width: 250
                    color: "#00ffffff"
                    anchors.left: schedulerRect.right
                    anchors.top: actionEventRect.bottom
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: 20

                    ColumnLayout {
                        id: columnLayout
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0


                        Rectangle {
                            id: schedulerDeviceSelectionContainer

                            color: "#00ffffff"
                            Layout.fillHeight: true
                            Layout.preferredHeight: 200
                            Layout.fillWidth: true
                            Label{
                                id: schedulerMachineSelectionLabel
                                height: 40
                                color: "#ffffff"
                                text: "Machine Selection"
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                verticalAlignment: Text.AlignVCenter
                                font.bold: true
                                anchors.rightMargin: 0
                                anchors.leftMargin: 20
                                anchors.topMargin: 10
                                font.pointSize: 12

                            }

                            Rectangle {
                                id:  schedulerDeviceSelectionRect


                                property  var selectedDevices: ({})
                                color: "#00d55b5b"
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: schedulerMachineSelectionLabel.bottom
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 0
                                anchors.rightMargin: 0
                                anchors.leftMargin: 20
                                anchors.topMargin: 20

                                Component.onCompleted: {initSelectedDevices()}

                                Label{
                                    id: schedulerDeviceSelectionfLabel
                                    height: 30
                                    color: "#ffffff"
                                    text: "Machine Available"
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    anchors.top: parent.top
                                    horizontalAlignment: Text.AlignLeft
                                    verticalAlignment: Text.AlignVCenter
                                    font.bold: false
                                    font.pointSize: 8
                                    anchors.rightMargin: 0
                                    anchors.leftMargin: 20
                                    anchors.topMargin: 0

                                }

                                ListView {
                                    id: schedulerDeviceSelectionListView
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    anchors.top: schedulerDeviceSelectionfLabel.bottom
                                    anchors.bottom: parent.bottom
                                    clip: true
                                    anchors.leftMargin: 10
                                    anchors.topMargin: 10
                                    model: modelData
                                    flickableDirection: Flickable.VerticalFlick
                                    boundsBehavior: Flickable.StopAtBounds
                                    ScrollBar.vertical: ScrollBar {}

                                    delegate: CheckDelegate{
                                        id: schedulerCheckDelegate
                                        contentItem: Text{
                                            text: modelData
                                            color: "#ffffff"

                                        }


                                        implicitHeight: 25

                                        indicator.x : 10
                                        indicator.width: 15
                                        indicator.height: 15
                                        leftPadding: 35
                                        topPadding: 0

                                        onClicked: {
                                            //console.log(text)
                                            schedulerDeviceSelectionRect.selectedDevices[contentItem.text] =  schedulerCheckDelegate.checked
                                            //console.log("selectedDevices: ", JSON.stringify(schedulerConfRect.selectedDevices))

                                        }


                                    }


                                }

                            } //schedulerConfRect


                        }

                        Rectangle {
                            id: setThresholdRect

                            color: "#00ffffff"
                            Layout.preferredHeight: 60
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Label{
                                id: setThresholdLabel
                                height: 40
                                color: "#ffffff"
                                text: "Set User Threshold "
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                verticalAlignment: Text.AlignVCenter
                                font.bold: true
                                font.pointSize: 12
                                anchors.rightMargin: 0
                                anchors.leftMargin: 20
                                anchors.topMargin: 0

                            }

                            CustomTextField {
                                id: setThresholdTextField
                                width: 200
                                height: 40
                                anchors.top: setThresholdLabel.bottom
                                anchors.topMargin: 20
                                placeholderText: "Insert Thresold"
                                anchors.horizontalCenter: parent.horizontalCenter
                                validator: IntValidator{
                                    bottom: 0
                                }
                                onEditingFinished: threshold = setThresholdTextField.text
                            }
                        }

                        Rectangle {
                            id: addConfigurationRect

                            color: "#00ffffff"
                            Layout.preferredHeight: 60
                            Layout.fillHeight: true
                            Layout.fillWidth: true

                            Label{
                                id: addConfigurationLabel
                                height: 40
                                color: "#ffffff"
                                text: "Add Configuration"
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                verticalAlignment: Text.AlignVCenter
                                font.pointSize: 12
                                font.bold: true
                                anchors.rightMargin: 0
                                anchors.leftMargin: 20
                                anchors.topMargin: 0


                            }

                            CustomButton {
                                id: addConfigurationButton
                                text: "Add"
                                anchors.top: addConfigurationLabel.bottom
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.topMargin: 20
                                onClicked: {
                                    //                                print("La lunghezza del campo threshold e': ",setThresholdTextField.text.length)
                                    //                                print("La lunghezza del campo nameEventLesson e': ",nameEventLessonText.text.length)
                                    if(nameEventLessonText.text.length===0  && setThresholdTextField.text.length ===0 ) {

                                        nameEventLessonText.errorCode = 1
                                        setThresholdTextField.errorCode = 1

                                    }else if(nameEventLessonText.text.length===0 &&setThresholdTextField.text.length !==0){
                                        nameEventLessonText.errorCode = 1
                                        setThresholdTextField.errorCode = 0
                                    }else if(nameEventLessonText.text.length!==0 &&setThresholdTextField.text.length ===0){
                                        nameEventLessonText.errorCode = 0
                                        setThresholdTextField.errorCode = 1
                                    }

                                    else{
                                        nameEventLessonText.errorCode = 0
                                        setThresholdTextField.errorCode = 0
                                        populateElemConfDict()
                                        backend.receiveConfElem(JSON.stringify(elemConfDict))
                                    }


                                }
                            }
                        }
                    }
                }

                Rectangle {
                    id: lessonEventViewRect
                    color: "#00ffffff"
                    border.color: "#00ffffff"
                    anchors.left: configurationRect.right
                    anchors.right: parent.right
                    anchors.top: actionEventRect.bottom
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 0
                    anchors.topMargin: 20
                    anchors.leftMargin: 0



                    Dialog {
                        id: moreInfoMessage
                        width: 400
                        height: 200
                        title: "Configuration Info"
                        contentItem: Rectangle{

                            ScrollView{
                                id: scrollView
                                anchors.fill:parent
                                clip: true
                                contentHeight: 400
                                Rectangle{
                                    id: confNameDialogRect
                                    width: parent.width
                                    height: 200
                                    color:"red"
                                    Label{
                                        id:confNameDialogLabel

                                    }

                                }
                                Rectangle{
                                    id: actionDictDialogRect
                                    width: parent.width
                                    height: 200
                                    color:"blue"
                                    anchors.top: confNameDialogRect.bottom
                                    anchors.topMargin: 0
                                    Label{
                                        id:actionDictDialogLabel

                                    }

                                }



                            }
                        }



                    }


                    Label {
                        id: lessonEventViewLabel
                        height: 40
                        color: "#ffffff"
                        text: "Event-Lesson View"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                        anchors.leftMargin: 0
                        anchors.rightMargin: 0
                        font.pointSize: 12
                        anchors.topMargin: 10

                    }
                    Rectangle{
                        id: headerRect
                        width: 200
                        height: 40
                        color: "#00ffffff"
                        anchors.top: lessonEventViewLabel.bottom
                        anchors.topMargin: 20
                        RowLayout {
                            id: rowHeader


                            Rectangle {
                                id: gymNameHeaderRect
                                color: "#6abfe2"
                                Layout.preferredHeight: 40
                                Layout.minimumHeight: 40
                                Layout.maximumHeight: 40
                                Layout.maximumWidth: 100
                                Layout.minimumWidth: 100
                                Layout.preferredWidth: 100
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                radius: 10
                                Label{
                                    id: gymNameHeaderLabel
                                    color: "#ffffff"
                                    text: "Gym Name"
                                    anchors.verticalCenter: parent.verticalCenter
                                    verticalAlignment: Text.AlignVCenter
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    font.bold: true


                                }

                            }
                            Rectangle {
                                id: roomNameHeaderRect
                                color: "#6abfe2"
                                Layout.preferredHeight: 40
                                Layout.minimumHeight: 40
                                Layout.maximumHeight: 40
                                Layout.maximumWidth: 150
                                Layout.minimumWidth: 150
                                Layout.preferredWidth: 150
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                radius: 10
                                Label{
                                    id: roomNameHeaderLabel
                                    color: "#ffffff"
                                    text: "Room Name"
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    font.bold: true

                                }

                            }
                            Rectangle {
                                id: confNameHeaderRect
                                color: "#6abfe2"
                                Layout.preferredHeight: 40
                                Layout.minimumHeight: 40
                                Layout.maximumHeight: 40
                                Layout.maximumWidth: 150
                                Layout.minimumWidth: 150
                                Layout.preferredWidth: 150
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                radius: 10
                                Label{
                                    id: confNameHeaderLabel

                                    color: "#ffffff"
                                    text: "Conf Name"
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    font.bold: true

                                }


                            }

                        } //End RowLayout
                    }

                    ListView {
                        id: configurationListView
                        property ListModel configListModel: ListModel{
                            id: configurationSRMModel;
                            ListElement{gymNameView: "Spinning-1";roomNameView: "Cardio";confNameView:"prova1";thresholdView: 20; }
                            ListElement{gymNameView: "Spinning-1";roomNameView: "HIIT";confNameView:"prova2";thresholdView:10; }
                        }
                        model: configurationSRMModel
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: headerRect.bottom
                        anchors.bottom: sendConfigurationRect.top
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 0
                        anchors.rightMargin: 0
                        anchors.topMargin: 10
                        spacing: 10


                        delegate: Rectangle {
                            width: 200
                            height: 40
                            color: "#00000000"
                            MouseArea {
                                id: mouseArea
                                //                            property string toolTipText
                                anchors.fill: row1
                                hoverEnabled: true

                            }


                            RowLayout {
                                id: row1

                                //                            ToolTip.delay: 250
                                //                            ToolTip.visible: mouseArea.containsMouse
                                //                            ToolTip.text: gymName+": "+roomName+"\n"+JSON.stringify(actionDict,null,1)+"\n"+"Active machine: " + activeMachines + "\n\n"+ "Room Capacity: " + threshold.toString()


                                Rectangle {
                                    id: gynNameConfViewRect
                                    color: "#6abfe2"
                                    Layout.preferredHeight: 40
                                    Layout.minimumHeight: 40
                                    Layout.maximumHeight: 40
                                    Layout.maximumWidth: 100
                                    Layout.minimumWidth: 100
                                    Layout.preferredWidth: 100
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Label{
                                        id: gynNameConfViewLabel
                                        color: "#ffffff"
                                        text: gymNameView
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.bold: true

                                    }

                                }
                                Rectangle {
                                    id: roomNameConfViewRect
                                    color: "#6abfe2"
                                    Layout.preferredHeight: 40
                                    Layout.minimumHeight: 40
                                    Layout.maximumHeight: 40
                                    Layout.maximumWidth: 150
                                    Layout.minimumWidth: 150
                                    Layout.preferredWidth: 150
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Label{
                                        id: roomNameConfViewLabel
                                        color: "#ffffff"
                                        text: roomNameView
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.bold: true

                                    }

                                }
                                Rectangle {
                                    id: confNameViewRect
                                    color: "#6abfe2"
                                    Layout.preferredHeight: 40
                                    Layout.minimumHeight: 40
                                    Layout.maximumHeight: 40
                                    Layout.maximumWidth: 150
                                    Layout.minimumWidth: 150
                                    Layout.preferredWidth: 150
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Label{
                                        id: confNameViewLabel

                                        color: "#ffffff"
                                        text: confNameView
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.bold: true

                                    }


                                }


                                Rectangle{
                                    id: moreInfoRect

                                    color: "#00ffffff"
                                    Layout.preferredHeight: 30
                                    Layout.minimumHeight: 30
                                    Layout.maximumHeight: 30
                                    Layout.maximumWidth: 50
                                    Layout.minimumWidth: 50
                                    Layout.preferredWidth: 50
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    CustomRemoveButton{
                                        id: moreInfoButton
                                        text: qsTr("INFO")
                                        anchors.fill: parent
                                        onClicked: {
                                            moreInfoMessage.visible = true
                                            confNameDialogLabel.text = configurationListView.configListModel.get(index).confNameView


                                        }
                                    }
                                }
                                Rectangle{
                                    id: removeConfigListModelElementRect

                                    color: "#00ffffff"
                                    Layout.preferredHeight: 30
                                    Layout.minimumHeight: 30
                                    Layout.maximumHeight: 30
                                    Layout.maximumWidth: 30
                                    Layout.minimumWidth: 30
                                    Layout.preferredWidth: 30
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    CustomRemoveButton{
                                        id: removeConfigListModelElementButton
                                        text: qsTr("X")
                                        anchors.fill: parent
                                        onClicked: {

                                            ///////////////////////////////////////////////////
                                            //MANDARE AL BACKEND IL NOME DELLA CONFIGURATION DA RIMUOVERE
                                            print(configurationListView.configListModel.get(index).confNameView)
                                            backend.removeConf(configurationListView.configListModel.get(index).confNameView)
                                            ///////////////////////////////////////////////////
                                            if(removeError === 0)
                                                configurationListView.configListModel.remove(index)



                                        }
                                    }
                                }

                            } //End RowLayout
                        } //End Delegate

                    }

                    Rectangle {
                        id: sendConfigurationRect
                        height: 100
                        color: "#00ffffff"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 0

                        CustomButton {
                            id: customButton
                            x: 360
                            y: 30
                            text: "Send Configuration"
                            onClicked: backend.sendConf()
                        }
                    }
                }

                //Scheduler Dict End

            } //Content Frame End

        }
    }

    Connections{
        target: backend
        function onSignalAle(errorCode){
            if(errorCode === 0){
                //Reset All
                gymComboBox.currentIndex =-1
                roomComboBox.currentIndex = -1
                nameEventLessonText.text = ""
                setThresholdTextField.text = ""
                scheduledListView.scheduledListModel.clear()

                /////////////////////////////
                //Bisogna Resettare anche le variabili !!!!
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
            else{
                print("Configuration Already present")
                duplicatedConfNameMessage.visible = true

            }
        }

        function onRemoveConfSig(value){
            removeError = value
        }

        function onGymSig(gymList){
            gymModelList.clear()
            gymModelList.append(gymList)
            console.log("gym Model for SRM",gymList)

        }

        function onRoomSig(roomList){
            roomModelList.clear()
            //deviceModelList.clear()
            console.log(roomList)
            roomModelList.append("room Model for SRM",roomList)
        }


    }


    ///////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////


    // Initialization of the Action Dict to pass to the Backend
    function initActionDict() {
        for(var [key, value] of Object.entries(actionDict)){

            for(var i = 0; i<modelData.count;i++){

                actionDict[key][modelData.get(i).name] = false;
            }


        }
        console.log( JSON.stringify(actionDict,null,1))
    }

    ///////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////


    function initSelectedDevices(){
        //        print("selectedDevicesInit")
        for(var i = 0; i<modelData.count;i++){
            schedulerDeviceSelectionRect.selectedDevices[modelData.get(i).name] = false

        }
        //        console.log( JSON.stringify(schedulerConfRect.selectedDevices))
    }

    ///////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////

    // Initialization of the Scheduler Dict to pass to the Backend
    function populateSchedulerDict() {
        scheduledDict = ({})
        for(var i = 0; i< scheduledListView.count; i++ ){
            var str = scheduledListView.itemAtIndex(i).selectedData

            while(str.includes("/")){
                str = str.replace("/", "-");
            }
            print("Il tipo e': ",scheduledListView.itemAtIndex(i).confType)
            print("La fine e': ",scheduledListView.itemAtIndex(i).finishTime)
            var key = str+" "+scheduledListView.itemAtIndex(i).startTime + " " +scheduledListView.itemAtIndex(i).finishTime
            if(scheduledListView.itemAtIndex(i).confType==="Event"){
                print("before",key)
                key = str+" "+scheduledListView.itemAtIndex(i).startTime
                print("after",key)
            }




            //scheduledDict[key] = {"Threshold": scheduledListView.itemAtIndex(i).threshold}
            scheduledDict[key] = {"Threshold": parseInt(threshold)}

            for(var [device, value] of Object.entries(schedulerDeviceSelectionRect.selectedDevices)){
                //                if (value === true){
                //                        scheduledDict[key][device] = "True"
                //                }
                scheduledDict[key][device] = value

            }

            //            for (var j =0; j <scheduledListView.itemAtIndex(i).activeMachines.lenght; j++){
            //                scheduledDict[key][scheduledListView.itemAtIndex(i).activeMachines.get(j)] = "True"
            //                print(j)
            //            }

        }
        //        console.log( JSON.stringify(scheduledDict,null,1))

    }

    ///////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    function populateElemConfDict(){
        populateSchedulerDict()
        elemConfDict["totalThreshold"] = parseInt(totalThreshold)
        elemConfDict["gymName"] = gymName
        elemConfDict["roomName"] = roomName
        elemConfDict["confName"] = confName
        elemConfDict["actionDict"] = actionDict
        elemConfDict["scheduledDict"] = scheduledDict

        //        print("ELEMENT CONF DICT:\n"+JSON.stringify(elemConfDict,null,1))

    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.5;height:480;width:640}D{i:1}D{i:6}D{i:10}D{i:14}
D{i:15}D{i:17}D{i:18}D{i:16}D{i:22}D{i:23}D{i:21}D{i:27}D{i:28}D{i:26}D{i:13}D{i:12}
D{i:31}D{i:32}D{i:30}D{i:37}D{i:38}D{i:36}D{i:43}D{i:44}D{i:42}D{i:49}D{i:50}D{i:48}
D{i:11}D{i:5}D{i:56}D{i:59}D{i:58}D{i:61}D{i:60}D{i:63}D{i:62}D{i:57}D{i:65}D{i:64}
D{i:55}D{i:54}D{i:90}D{i:92}D{i:93}D{i:91}D{i:89}D{i:98}D{i:99}D{i:97}D{i:102}D{i:103}
D{i:101}D{i:88}D{i:87}D{i:105}D{i:112}D{i:116}D{i:115}D{i:118}D{i:117}D{i:120}D{i:119}
D{i:114}D{i:113}D{i:121}D{i:139}D{i:138}D{i:104}D{i:4}D{i:3}D{i:2}D{i:140}
}
##^##*/
