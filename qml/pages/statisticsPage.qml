import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
//import QtWebEngine 1.10



import "../controls"

Item {
    property string gymName: ""
    property string roomName: ""
    property string deviceName: ""
    property string startDate: ""
    property string endDate: ""
    property string startTime: ""
    property string endTime: ""

    Rectangle{
        id: statisticsContainer
        color: "#2c313c"
        anchors.fill: parent
        Label{
            id: statisticsContainerLabel
            height: 40
            color: "#ffffff"
            text: "Statistics"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.bold: true
            font.pointSize: 12
            anchors.rightMargin: 0
            anchors.leftMargin: 20
            anchors.topMargin: 10


        }

        GridLayout {
            id: gridLayoutStatistics
            height: 200
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: statisticsContainerLabel.bottom
            anchors.leftMargin: 20
            antialiasing: true
            anchors.rightMargin: 20
            anchors.topMargin: 10
            columns: 5
            rows: 2

            ListModel {
                id: gymModelStat
                ListElement{name:"Crocetta"}
                ListElement{name:"Donato"}
                ListElement{name:"Pippo"}
            }

            ListModel {
                id: roomModelStat
                ListElement{name:"room1"}
                ListElement{name:"room2"}
                ListElement{name:"room3"}
            }

            ListModel {
                id: machineModelStat
                ListElement{name:"1"}
                ListElement{name:"2"}
                ListElement{name:"3"}
            }

            Rectangle {
                id: rectangleGymStat
                height: parent.height
                color: "#00ffffff"
                Layout.maximumWidth: 140
                Layout.maximumHeight: 80
                Layout.minimumHeight: 80
                Layout.preferredHeight: 80
                Layout.fillHeight: false
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                clip: true
                Layout.leftMargin: 0
                Layout.fillWidth: true
                Component.onCompleted: {
                    backend.getAdjacency('None','None','None')
                }

                Label {
                    id: labelGymSelectionStat
                    color: "#feffff"
                    text: "Gym"
                    anchors.top: parent.top
                    anchors.topMargin: 0
                }

                CustomComboBox {
                    id: gymComboBoxStat
                    anchors.top: labelGymSelectionStat.bottom
                    implicitHeight: 40
                    delegate: ItemDelegate {
                        width: parent.width
                        onPressed: {
                            deviceModelStat.clear()
                            gymName = name
                            backend.getAdjacency( gymName,'None','None')

                        }
                        contentItem: Text {
                            text: name
                            elide: Text.ElideRight
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    model: gymModelStat
                    currentIndex: -1
                    displayText: currentText
                    anchors.topMargin: 10
                    textRole: "name"
                    implicitWidth: parent.width
                }

            }

            Rectangle {
                id: rectangleRoomStat
                width: CustomComboBox.width
                height: parent.height
                color: "#00ffffff"
                Layout.maximumWidth: 140
                Layout.maximumHeight: 80
                Layout.minimumHeight: 80
                Layout.preferredHeight: 80
                Layout.fillHeight: false
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                clip: true
                Label {
                    id: labelRoomSelectionStat
                    color: "#feffff"
                    text: "Room"
                    anchors.top: parent.top
                    anchors.topMargin: 0
                }

                CustomComboBox {
                    id: roomComboBoxStat
                    anchors.top: labelRoomSelectionStat.bottom
                    implicitHeight: 40
                    delegate: ItemDelegate {
                        width: parent.width
                        onPressed: {
                            roomName = name
                            backend.getAdjacency(gymName,roomName,'None')

                        }
                        contentItem: Text {
                            text: name
                        }
                    }
                    model: roomModelStat
                    currentIndex: -1
                    displayText: currentText
                    anchors.topMargin: 10
                    textRole: "name"
                    implicitWidth: parent.width
                }
                Layout.fillWidth: true
            }

            Rectangle {
                id: rectangleMachineStat
                width: CustomComboBox.width
                height: 60
                color: "#00ffffff"
                Layout.maximumWidth: 140
                Layout.maximumHeight: 80
                Layout.minimumHeight: 80
                Layout.preferredHeight: 80
                Layout.fillHeight: false
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                clip: true
                Label {
                    id: labelMachine1SelectionStat
                    color: "#feffff"
                    text: "Machine"
                    anchors.top: parent.top
                    anchors.topMargin: 0
                }

                CustomComboBox {
                    id: machineComboBoxStat
                    anchors.top: labelMachine1SelectionStat.bottom
                    implicitHeight: 40
                    delegate: ItemDelegate {
                        width: parent.width
                        onPressed: {
                            deviceName = name
                            print("Il device scelto e': "+deviceName)
                            backend.getAdjacency(gymName,roomName,deviceName)

                        }
                        contentItem: Text {
                            text: name
                        }
                    }
                    model: machineModelStat
                    currentIndex: -1
                    displayText: currentText
                    anchors.topMargin: 10
                    textRole: "name"
                    implicitWidth: parent.width
                }
                Layout.fillWidth: true
            }



            Rectangle {
                id: dataStartRect
                height: parent.height
                color: "#00ffffff"
                Layout.maximumWidth: 140
                Layout.minimumHeight: 80
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                clip: true
                Layout.leftMargin: 0
                Layout.fillHeight: false
                Layout.maximumHeight: 80
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                Layout.row: 1
                Layout.column: 0
                Label {
                    id: dataStartLabel
                    color: "#feffff"
                    text: "Start Data"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                }
                Rectangle{
                    id: dataCalendarStartRect
                    color: "#00ffffff"
                    radius: 10
                    border.color: "#ffffff"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: dataStartLabel.bottom
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: 10
                    Label{
                        id: dataCalendarStartLabelText
                        text: "Selected Date"
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                        color: "#ffffff"

                    }

                    MouseArea{
                        anchors.fill: parent
                        onClicked: datePopupStart.open()

                    }

                    Popup{
                        id: datePopupStart
                        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
                        Rectangle{
                            width: 200
                            height: 200
                            color: "#ffffff"
                            x: -10
                            y: -200
                            CustomDatePicker{
                                id: datePickerStart

                                anchors.fill: parent

                                Component.onCompleted: set(new Date()) // today
                                onClicked:{

                                    dataCalendarStartLabelText.text = qsTr(Qt.formatDate(date, 'dd-MM-yyyy'))
                                    startDate = qsTr(Qt.formatDate(date, 'dd-MM-yyyy'))

                                    datePopupStart.close()



                                }
                            }
                        }
                    } // end Popup
                }


            }

            Rectangle {
                id: timeStartRect
                height: parent.height
                color: "#00ffffff"
                Layout.maximumWidth: 140
                Layout.minimumHeight: 80
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                clip: true
                Layout.leftMargin: 0
                Layout.fillHeight: false
                Layout.maximumHeight: 80
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                Layout.row: 1
                Layout.column: 1
                Label {
                    id: timeStartLabel
                    color: "#feffff"
                    text: "Start Time"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.topMargin: 0
                }
                Rectangle{
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: timeStartLabel.bottom
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 10
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

            Rectangle {
                id: dataEndRect
                height: parent.height
                color: "#00ffffff"
                Layout.maximumWidth: 140
                Layout.minimumHeight: 80
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                clip: true
                Layout.leftMargin: 0
                Layout.fillHeight: false
                Layout.maximumHeight: 80
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                Layout.row: 1
                Layout.column: 2
                Label {
                    id: dataEndLabel
                    color: "#ffffff"
                    text: "End Data"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: 0
                }
                Rectangle{
                    id: dataCalendarEndRect
                    color: "#00ffffff"
                    radius: 10
                    border.color: "#ffffff"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: dataEndLabel.bottom
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: 10
                    Label{
                        id: dataCalendarEndLabelText
                        text: "Selected Date"
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                        color: "#ffffff"

                    }

                    MouseArea{
                        anchors.fill: parent
                        anchors.topMargin: 0
                        onClicked: datePopupEnd.open()

                    }

                    Popup{
                        id: datePopupEnd
                        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
                        Rectangle{
                            width: 200
                            height: 200
                            color: "#ffffff"

                            CustomDatePicker{
                                id: datePickerEnd

                                anchors.fill: parent

                                Component.onCompleted: set(new Date()) // today
                                onClicked:{

                                    dataCalendarEndLabelText.text = qsTr(Qt.formatDate(date, 'dd-MM-yyyy'))
                                    endDate = qsTr(Qt.formatDate(date, 'dd-MM-yyyy'))

                                    datePopupEnd.close()



                                }
                            }
                        }
                    } // end Popup
                }

            }

            Rectangle {
                id: timeEndRect
                height: parent.height
                color: "#00ffffff"
                Layout.maximumWidth: 140
                Layout.minimumHeight: 80
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                clip: true
                Layout.leftMargin: 0
                Layout.fillHeight: false
                Layout.maximumHeight: 80
                Layout.fillWidth: true
                Layout.preferredHeight: 80
                Layout.row: 1
                Layout.column: 3
                Label {
                    id: timeEndLabel
                    color: "#feffff"
                    text: "End Time"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: 0
                }
                Rectangle{
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: timeEndLabel.bottom
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 10
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                    color: "#00ffffff"
                    CustomTimePicker{
                        id: endTimePicker
                        anchors.fill: parent

                    }
                }




            }


            Rectangle {
                id: rectangleStatShow
                width: CustomButton.width
                height: parent.height
                color: "#00ffffff"
                Layout.maximumHeight: 80
                Layout.minimumHeight: 80
                Layout.preferredHeight: 80
                Layout.minimumWidth: 80
                Layout.maximumWidth: 150
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                clip: true
                Layout.preferredWidth: 100
                Layout.row: 1
                Layout.column: 4
                Label {
                    id: buttonShowStat
                    color: "#feffff"
                    anchors.top: parent.top
                    anchors.topMargin: 0
                }

                CustomButton {
                    id: showButtonStat
                    width: parent.width
                    height: 30
                    text: qsTr("Show Statistic")
                    anchors.top: buttonShowStat.bottom
                    onClicked: {

                        var getStatDict = ({"deviceID":deviceName,"startTime":startDate+" "+startTimePicker.timeValue,"endTime":endDate+" "+endTimePicker.timeValue})
                        backend.getStatistics(JSON.stringify(getStatDict))
                        resetCurrentIndex()

                    }
                    anchors.topMargin: 10
                }
                Layout.fillWidth: true
            }
        }

        Rectangle {
            id: webViewRect
            color: "#f30000"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: gridLayoutStatistics.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: 20
            anchors.bottomMargin: 0
            anchors.rightMargin: 0
            anchors.leftMargin: 0
//            WebEngineView {
//                    anchors.fill: parent
//                    url: "https://thingspeak.com/channels/1663105"
//                }
        }



//        Rectangle {
//            id: imageRect

//            color: "#00ffffff"
//            anchors.left: parent.left
//            anchors.right: parent.right
//            anchors.top: gridLayoutStatistics.bottom
//            anchors.bottom: parent.bottom
//            anchors.bottomMargin: 0
//            anchors.rightMargin: 0
//            anchors.leftMargin: 0
//            anchors.topMargin: 20

//            RowLayout {
//                id: rowLayout
//                anchors.fill: parent

//                Image{
//                    id: derivative
//                    Layout.fillHeight: true
//                    Layout.fillWidth: true
////                    source: Qt.resolvedUrl("../../images/statistics/prova.png")
//                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
//                    Layout.maximumHeight: 700
//                    Layout.maximumWidth: 700
//                    anchors.leftMargin: 200
//                    sourceSize.height: 240
//                    sourceSize.width: 360
//                    clip: true
//                    fillMode: Image.PreserveAspectFit
//                }

//                Image{
//                    id: counter


//                    Layout.fillHeight: true
//                    Layout.fillWidth: true
////                    source: Qt.resolvedUrl("../../images/statistics/prova.png")
//                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
//                    Layout.maximumHeight: 700
//                    Layout.maximumWidth: 700

//                    sourceSize.height: 240
//                    sourceSize.width: 360
//                    clip: true
//                    fillMode: Image.PreserveAspectFit
//                }
//            }



//        }


    }

    function resetCurrentIndex(){
        gymComboBoxStat.currentIndex = -1
        roomComboBoxStat.currentIndex = -1
        machineComboBoxStat.currentIndex = -1
        gymName = ''
        roomName = ''
        deviceName = ''

        console.log(gymName,roomName,deviceName)
    }

    Connections{
        target: backend

        function onShowImageSig(code){
            if (code ===0 ){
                print("Show immage")
                derivative.source = Qt.resolvedUrl("../../images/statistics/prova.png")
                counter.source= Qt.resolvedUrl("../../images/statistics/prova.png")

            }
            else {
                print("Do Nothing")
            }
        }

    }




}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}D{i:2}D{i:4}D{i:8}D{i:12}D{i:16}D{i:21}D{i:26}D{i:31}D{i:39}
D{i:43}D{i:51}D{i:55}D{i:3}D{i:58}D{i:1}D{i:59}
}
##^##*/
