import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.0
import "../controls"



Item {
    id: itemMachineControl


    Rectangle{
        id: machineControlRectangle
        visible: true
        anchors.fill: parent
        color: "#2c313c"


        Rectangle{
            id : adjacentSelectionContainer

            color: "#00ffffff"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            height: parent.height/3






            Label{
                id: labelAdjacentContainer
                height: 40
                text: qsTr("ADJACENT SELECTION")
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                clip: true
                anchors.rightMargin: 10
                anchors.leftMargin: 20
                anchors.topMargin: 10
                color: "#ffffff"
                font.pointSize: 12

            }

            RowLayout {
                id: rowLayout
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: labelAdjacentContainer.bottom
                anchors.bottom: parent.bottom
                anchors.rightMargin: 20
                anchors.leftMargin: 20
                anchors.bottomMargin: 10
                anchors.topMargin: 10

                ListModel{
                    id: gymModelList

                }
                ListModel{
                    id: roomModelList

                }

                Rectangle {
                    id: rectangle
                    width: CustomComboBox.width

                    color: "#00ffffff"
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.fillWidth: true


                    Label{
                        id: labelGymSelection
                        color: "#feffff"
                        text : "GYM"
                        anchors.top: parent.top
                        anchors.topMargin: 0

                    }
                    CustomComboBox{
                        id: gymComboBox
                        anchors.top: labelGymSelection.bottom
                        anchors.topMargin:10
                        model: gymModelList


                        delegate: ItemDelegate {

                                contentItem: Text {
                                    text : name
                                    elide: Text.ElideRight
                                    verticalAlignment: Text.AlignVCenter
                                }
                                onPressed: {
                                    backend.retrieveData(name,'None')

                                }




                            }


                    }
                }


                Rectangle {
                    id: rectangle1
                    width: CustomComboBox.width
                    color: "#00ffffff"
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.fillWidth: true
                    Label {
                        id: labelGymSelection1
                        color: "#feffff"
                        text: "ROOM"
                        anchors.top: parent.top
                        anchors.topMargin: 0
                    }

                    CustomComboBox {
                        anchors.top: labelGymSelection1.bottom
                        anchors.topMargin: 10
                        model: roomModelList
                        delegate: ItemDelegate {

                                contentItem: Text {
                                    text: name

                                }
                        }

                    }
                }

                Rectangle {
                    id: rectangle2
                    width: CustomComboBox.width
                    color: "#00ffffff"
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.fillWidth: true
                    Label {
                        id: labelGymSelection2
                        color: "#feffff"
                        text: "MACHINE-1"
                        anchors.top: parent.top
                        anchors.topMargin: 0
                    }

                    CustomComboBox {
                        anchors.top: labelGymSelection2.bottom
                        anchors.topMargin: 10
                    }
                }

                Rectangle {
                    id: rectangle3
                    width: CustomComboBox.width
                    color: "#00ffffff"
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.fillWidth: true
                    Label {
                        id: labelGymSelection3
                        color: "#feffff"
                        text: "MACHINE-2"
                        anchors.top: parent.top
                        anchors.topMargin: 0
                    }

                    CustomComboBox {
                        anchors.top: labelGymSelection3.bottom
                        anchors.topMargin: 10
                    }
                }


                Rectangle {
                    id: rectangle4
                    color: "#00ffffff"
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.fillWidth: true
                    Layout.preferredWidth: 100
                    Layout.minimumWidth: 80
                    Layout.maximumWidth: 150



                    Label {
                        id: buttonSendLabel
                        color: "#feffff"
                        anchors.top: parent.top
                        anchors.topMargin: 0
                    }

                    CustomButton {
                        anchors.top: buttonSendLabel.bottom
                        anchors.topMargin: 10
                        width: parent.width


                    }
                }
            }
            Component.onCompleted: backend.loadGymsStartup()

        }

        Rectangle{
            id : adjacentViewContainer

            color: "#00ffffff"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: adjacentSelectionContainer.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: 0
            clip: false
            height: parent.height *(2/3)

            Label{
                id: labelViewContainer
                height: 40
                text: qsTr("ADJACENT VIEW")
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: 0
                anchors.leftMargin: 20
                anchors.topMargin: 10
                color: "#ffffff"
                font.pointSize: 12

            }

            Flickable {
                id: flickable1
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: labelViewContainer.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: 0
                contentHeight: parent.height
                contentWidth: parent.width

                clip: true
            }


        }
    }

    Connections{
        target: backend
        function onGymSig(gymList){
            gymModelList.clear()
            gymModelList.append(gymList)
            console.log(gymList)

        }

        function onRoomSig(roomList){
            roomModelList.clear()
            //deviceModelList.clear()
            console.log(roomList)
            roomModelList.append(roomList)
        }



    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}D{i:3}D{i:6}D{i:7}D{i:5}
D{i:9}D{i:10}D{i:8}D{i:12}D{i:13}D{i:11}D{i:15}D{i:16}D{i:14}D{i:18}D{i:19}D{i:17}
D{i:4}D{i:2}D{i:21}D{i:22}D{i:20;invisible:true}D{i:1}D{i:23}
}
##^##*/
