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







        Label{
            id: labelAdjacentContainer
            x: 20
            y: 0
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
            anchors.topMargin: 0
            color: "#ffffff"
            font.pointSize: 12

        }
        Flickable {
            id: flickable
            //            height: parent.height/2
            height: parent.height/2
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: labelAdjacentContainer.bottom
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            contentWidth: parent.width
            contentHeight: 400
            clip: true

            Rectangle{
                id : adjacentSelectionContainer
                height: 200
                color: "#00ffffff"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0






                Rectangle {
                    id: rectangleGymRoomSelection
                    x: 20
                    y: 60
                    height: 120
                    color: "#00ffffff"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 20
                    anchors.rightMargin: 10
                    anchors.leftMargin: 20

                    Rectangle{
                        id: labelRectangleGymsRooms
                        anchors.top:parent.top
                        anchors.topMargin: 10
                        height: 40
                        color: "#00ffffff"
                        width: parent.width
                        Label{
                            id: gymSelectionLabel
                            anchors.top:parent.top
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            anchors.left:parent.left
                            height: parent.height
                            color: "#ffffff"
                            width: gymSelectionComboBox.width
                            text : "GYMS"

                        }

                        Label{
                            id: roomSelectionLabel
                            anchors.top: parent.top
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            anchors.left: gymSelectionLabel.right
                            anchors.leftMargin: 20
                            height: parent.height
                            color: "#ffffff"
                            width: roomSelectionComboBox.width
                            text: "ROOMS"

                        }


                    }

                    Rectangle{
                        id: comboBoxRectangleGymsRooms

                        anchors.top:labelRectangleGymsRooms.bottom
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.topMargin: 20
                        height: 40
                        color: "#00ffffff"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        CustomComboBox {
                            id: gymSelectionComboBox
                            anchors.left: parent.left
                            anchors.top: parent.top

                            width: 200
                            //Layout.fillWidth: true
                            model: ["First","Second","Third"]

                            currentIndex: -1


                        }
                        CustomComboBox {
                            id: roomSelectionComboBox


                            width: 200
                            anchors.left: gymSelectionComboBox.right
                            anchors.top: parent.top
                            anchors.topMargin: 0

                            anchors.leftMargin: 20

                            model: ["First","Second","Third"]

                            currentIndex: -1


                        }
                    }


                }

                Rectangle {
                    id: rectangleMachineAdjacentSelection
                    x: 20
                    y: 190
                    height: 120
                    color: "#00ffffff"

                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: rectangleGymRoomSelection.bottom
                    anchors.topMargin: 10
                    anchors.rightMargin: 10
                    anchors.leftMargin: 20

                    Rectangle {
                        id: labelRectangleMachines
                        y: -170
                        width: parent.width
                        height: 40
                        color: "#00ffffff"
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.leftMargin: 0
                        Label {
                            id: machine1SelectionLabel
                            width: gymSelectionComboBox.width
                            height: parent.height
                            color: "#ffffff"
                            text: "MACHINE-1"
                            anchors.left: parent.left
                            anchors.top: parent.top
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            anchors.leftMargin: 0
                            anchors.topMargin: 0
                        }

                        Label {
                            id: machine2SelectionLabel
                            width: roomSelectionComboBox.width
                            height: parent.height
                            color: "#ffffff"
                            text: "MACHINE-2"
                            anchors.left: machine1SelectionLabel.right
                            anchors.top: parent.top
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            anchors.leftMargin: 20
                        }
                        anchors.topMargin: 0
                    }

                    Rectangle{
                        id: comboBoxRectangleMachines
                        x: 0
                        anchors.top: labelRectangleMachines.bottom
                        anchors.topMargin: 0


                        CustomComboBox {
                            id: firstMachineSelection
                            width: 200
                            //Layout.preferredWidth: 300
                            //Layout.fillWidth: true
                            model: ["First","Second","Third"]

                            currentIndex: -1


                        }
                        CustomComboBox {
                            id: secondMachineSelection
                            width: 200
                            //Layout.preferredWidth: 300
                            anchors.left: firstMachineSelection.right
                            anchors.leftMargin: 20
                            //Layout.fillWidth: true
                            model: ["First","Second","Third"]

                            currentIndex: -1


                        }

                        CustomButton {
                            id: machineControlSendConfigurationButton
                            width: 140
                            text: "Send Conf"

                            //Layout.maximumWidth: 200
                            //Layout.preferredHeight: 40
                            //Layout.preferredWidth: 250
                            //Layout.fillWidth: true
                            Layout.fillHeight: true
                            anchors.left:secondMachineSelection.right
                            anchors.leftMargin: 20
                            enabled: if(comboBox.count !==0){
                                         return true
                                     }else{
                                         return false
                                     }

                            onClicked: {
                                backend.jsonSave("testo")
                            }
                        }
                    }
                }

            }
        }

        Flickable {
            id: flickable1
            height: parent.height/2
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: flickable.bottom
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            contentHeight: parent.height
            contentWidth: parent.width

            clip: true

            Rectangle{
                id : adjacentViewContainer
                color: "#00ffffff"
                anchors.fill: parent
                clip: false

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
                    anchors.topMargin: 0
                    color: "#ffffff"
                    font.pointSize: 12

                }

                RowLayout{
                    id: rowLayout
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: labelViewContainer.bottom
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 20
                    Rectangle{
                        id: selectionMachine
                        anchors.top:parent.top
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        width: parent.width*(1/3)
                        color: "#00ffffff"

                        GridLayout {
                            id: gridPairView

                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.topMargin: 40
                            anchors.rightMargin: 10
                            anchors.leftMargin: 20
                            rows: 1
                            columns: 3

                            CustomComboBox {
                                id: machinePairSelection
                                Layout.preferredWidth: 300
                                Layout.fillWidth: true
                                model: ["First","Second","Third"]

                                currentIndex: -1


                            }



                            CustomButton {
                                id: machinePairView
                                text: "Send"
                                Layout.maximumWidth: 200
                                Layout.preferredHeight: 40
                                Layout.preferredWidth: 250
                                Layout.fillWidth: true
                                enabled: if(comboBox.count !==0){
                                             return true
                                         }else{
                                             return false
                                         }

                                onClicked: {
                                    backend.jsonSave("testo")
                                }
                            }
                        }




                    }
                    Rectangle{
                        anchors.top:parent.top
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        width: parent.width*(2/3)
                        color: "#00ffffff"


                    }


                }


            }
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:2}D{i:7}D{i:8}D{i:6}D{i:10}D{i:11}D{i:9}
D{i:5}D{i:14}D{i:15}D{i:13}D{i:17}D{i:18}D{i:19}D{i:16}D{i:12}D{i:4}D{i:3}D{i:22}
D{i:26}D{i:27}D{i:25}D{i:24}D{i:28}D{i:23}D{i:21}D{i:20}D{i:1}
}
##^##*/
