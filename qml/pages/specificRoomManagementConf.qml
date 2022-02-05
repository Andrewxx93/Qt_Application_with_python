import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.11

import QtQuick.Controls 2.15
import "../controls"


Item {

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
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.leftMargin: 0
            anchors.topMargin: 0
            clip: false
            anchors.rightMargin: 0
            height: 220

            property var actionDict: {"0":{},"1":{},"2":{},"3":{}}

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
                ListElement{
                    name : 'quarto'
                }
                ListElement{
                    name : 'quinto'
                }
                ListElement{
                    name : 'sesto'
                }
                ListElement{
                    name : 'settimo'
                }
                ListElement{
                    name : 'ottavo'
                }
                ListElement{
                    name : 'nono'
                }
                ListElement{
                    name : 'decimo'
                }


            }

            Component.onCompleted: initActionDict()

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

                        // gyms model list loading
                        //                Component.onCompleted: {
                        //                    backend.pairList('None','None','None','None')
                        //                }

                        ListModel{
                            id: gymModelList
                            ListElement{
                                name: "Crocetta"
                            }
                            ListElement{
                                name: "Salvario"
                            }
                            ListElement{
                                name: "Donato"
                            }


                        }
                        ListModel{
                            id: roomModelList
                            ListElement{
                                name: "Cardio"
                            }
                            ListElement{
                                name: "Tapis"
                            }
                            ListElement{
                                name: "Spinning"
                            }



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
                                    //                                    onPressed: {
                                    //                                        itemMCC.gymName = name
                                    //                                        backend.pairList( itemMCC.gymName,'None','None','None')


                                    //                                    }

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
                                    //                                    onPressed: {
                                    //                                        itemMCC.roomName = name
                                    //                                        backend.pairList( itemMCC.gymName,itemMCC.roomName,'None','None')

                                    //                                    }
                                }

                            }
                        }

                    }



                }

                //Trainer rect end

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
                                id: userText
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
                                console.log(userText.text)
                                actionEventRect.actionDict["0"][userText.text] =  userCheckDelegate.checked
                                console.log( JSON.stringify(actionEventRect.actionDict))

                            }


                        }


                    }

                }
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
                                id: ownerText
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
                                console.log(ownerText.text)
                                actionEventRect.actionDict["1"][ownerText.text] =  ownerCheckDelegate.checked
                                console.log( JSON.stringify(actionEventRect.actionDict))

                            }

                        }
                    }

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
                                id: workerText
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
                                console.log(workerText.text)
                                actionEventRect.actionDict["2"][workerText.text] =  workerCheckDelegate.checked
                                console.log( JSON.stringify(actionEventRect.actionDict))

                            }

                        }
                    }

                }

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
                                id: trainerText
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
                                console.log(trainerText.text)
                                actionEventRect.actionDict["3"][trainerText.text] =  trainerCheckDelegate.checked
                                console.log( JSON.stringify(actionEventRect.actionDict))

                            }

                        }
                    }

                }
            }


            //RowLayout End





        }

        Rectangle {
            id: rectangle
            color: "#00ffffff"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: actionEventRect.bottom
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0

                            Rectangle {
                                id: buttonRect
                                width: 200
                                height: 200
                                color: "#ffffff"
                                anchors.top: parent.top
                                anchors.topMargin: 0
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                Layout.preferredWidth: 150
                                Layout.maximumWidth: 200

                                Button{
                                    text: "Send"
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    anchors.bottom: parent.bottom
                                    font.bold: true
                                    anchors.rightMargin: 0
                                    anchors.leftMargin: 0
                                    anchors.bottomMargin: 0

                                    onClicked: {
                                        console.log(actionEventRect.actionDict)

                                        backend.conf_SRM(JSON.stringify(actionEventRect.actionDict))
                                    }


                                }
                            }





        }
    }

    function initActionDict() {
        for(var [key, value] of Object.entries(actionEventRect.actionDict)){

            for(var i = 0; i<modelData.count;i++){

                actionEventRect.actionDict[key][modelData.get(i).name] = false;
            }


        }
        console.log( JSON.stringify(actionEventRect.actionDict))
    }

    Connections{
        target: backend


    }


}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:3}D{i:14}D{i:18}D{i:22}D{i:27}D{i:28}
D{i:26}D{i:32}D{i:33}D{i:31}D{i:17}D{i:16}D{i:37}D{i:38}D{i:36}D{i:43}D{i:44}D{i:42}
D{i:49}D{i:50}D{i:48}D{i:55}D{i:56}D{i:54}D{i:15}D{i:2}D{i:62}D{i:61}D{i:60}D{i:1}
D{i:63}
}
##^##*/
