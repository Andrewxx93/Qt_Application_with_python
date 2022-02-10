import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.11

import QtQuick.Controls 2.15
import "../controls"

Item {

    Rectangle {
        id: userRegistrationContainer

        color: "#2c313c"
        anchors.fill: parent

        Rectangle {
            id: userRegistrationRect
            height: 200
            color: "#00ffffff"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.topMargin: 10
            property var newUserDict: ({})

            RowLayout {
                id: rowLayoutUserRegistration
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
                implicitHeight: 100

                Rectangle {
                    id: userIDRect
                    width: 200
                    height: 200
                    color: "#00ffffff"
                    Layout.maximumWidth: 200
                    Layout.preferredWidth: 100
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Label{
                        id: userIDLabel
                        height: 20
                        color: "#ffffff"
                        text: "User ID"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.topMargin: 10

                    }

                    Rectangle {
                        id: textFieldIDRect
                        width: 200
                        color: "#00ffffff"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: userIDLabel.bottom
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0

                        CustomTextField{
                            id: userIDTextField
                            anchors.verticalCenter: parent.verticalCenter
                            horizontalAlignment: Text.AlignHCenter
                            placeholderText: "User ID"
                            implicitWidth: parent.width



                        }
                    }
                }

                Rectangle {
                    id: userNameRect
                    width: 200
                    height: 200
                    color: "#00ffffff"
                    Layout.maximumWidth: 200
                    Layout.preferredWidth: 100
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Label {
                        id: userNameLabel
                        height: 20
                        color: "#ffffff"
                        text: "Name"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 0
                        anchors.topMargin: 10
                        anchors.rightMargin: 0
                    }

                    Rectangle {
                        id: textFieldNameRect
                        width: 200
                        color: "#00ffffff"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: userNameLabel.bottom
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 0
                        anchors.topMargin: 0
                        anchors.rightMargin: 0
                        anchors.bottomMargin: 0
                        CustomTextField {
                            id: userNameTextField
                            anchors.verticalCenter: parent.verticalCenter
                            horizontalAlignment: Text.AlignHCenter
                            placeholderText: "User Name"
                            implicitWidth: parent.width
                        }

                    }
                }

                Rectangle {
                    id: userSurnameRect
                    width: 200
                    height: 200
                    color: "#00ffffff"
                    Layout.maximumWidth: 200
                    Layout.preferredWidth: 100
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Label {
                        id: userSurnameLabel
                        height: 20
                        color: "#ffffff"
                        text: "Surname"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 0
                        anchors.topMargin: 10
                        anchors.rightMargin: 0
                    }
                    Rectangle {
                        id: textFieldSurnameRect
                        width: 200
                        color: "#00ffffff"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: userSurnameLabel.bottom
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 0
                        anchors.topMargin: 0
                        anchors.rightMargin: 0
                        anchors.bottomMargin: 0
                        CustomTextField {
                            id: userSurnameTextField
                            anchors.verticalCenter: parent.verticalCenter
                            horizontalAlignment: Text.AlignHCenter
                            placeholderText: "User surname"
                            implicitWidth: parent.width
                        }

                    }


                }

                Rectangle {
                    id: userAgeRect
                    width: 200
                    height: 200
                    color: "#00ffffff"
                    Layout.maximumWidth: 200
                    Layout.preferredWidth: 100
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Label {
                        id: userAgeLabel
                        height: 20
                        color: "#ffffff"
                        text: "Age"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 0
                        anchors.topMargin: 10
                        anchors.rightMargin: 0
                    }

                    Rectangle {
                        id: textFieldAgeRect
                        width: 200
                        color: "#00ffffff"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: userAgeLabel.bottom
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 0
                        anchors.topMargin: 0
                        anchors.rightMargin: 0
                        anchors.bottomMargin: 0
                        CustomTextField {
                            id: userAgeTextField
                            anchors.verticalCenter: parent.verticalCenter
                            horizontalAlignment: Text.AlignHCenter
                            placeholderText: "User Age"
                            implicitWidth: parent.width
                        }

                    }
                }

                Rectangle {
                    id: userTypeRect
                    width: 200
                    height: 200
                    color: "#00ffffff"
                    Layout.preferredWidth: 100
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.maximumWidth: 200
                    Label {
                        id: userTypeLabel
                        height: 20
                        color: "#ffffff"
                        text: "Type"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.rightMargin: 0
                        anchors.topMargin: 10
                        anchors.leftMargin: 0
                    }

                    Rectangle {
                        id: comboBoxTypeRect
                        width: 200
                        color: "#00ffffff"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: userTypeLabel.bottom
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.topMargin: 0
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 0
                        ListModel{
                            id: userTypeModelList
                            ListElement{
                                type: "User"
                                typeCode : 0

                            }
                            ListElement{
                                type: "Owner"
                                typeCode : 1

                            }
                            ListElement{
                                type: "Worker"
                                typeCode : 2

                            }

                            ListElement{
                                type: "Trainer"
                                typeCode : 3

                            }
                        }

                        CustomComboBox {
                            id: comboBoxUserType
                            height: 40
                            anchors.verticalCenter: parent.verticalCenter
                            model: userTypeModelList
                            implicitWidth: parent.width
                            implicitHeight: 30

                            //In order to display the text on the ComboBox when selected
                            currentIndex: -1
                            textRole: 'type'
                            displayText: currentText
                            delegate: ItemDelegate {

                                contentItem: Text {
                                    text : type
                                    color: "#ffffff"
                                    elide: Text.ElideRight
                                    verticalAlignment: Text.AlignVCenter

                                }
                                onPressed:{
                                    userRegistrationRect.newUserDict["type"] = typeCode


                                }

                            }




                        }

                        CustomButton {
                            id: customButton
                            x: -40
                            height: 40
                            text: "Add User"
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: comboBoxUserType.bottom
                            anchors.centerIn: parent.Center
                            anchors.leftMargin: 0
                            anchors.rightMargin: 0
                            anchors.topMargin: 10
                            onClicked: {

                                userRegistrationRect.newUserDict["userID"] = userIDTextField.text
                                userRegistrationRect.newUserDict["name"] = userNameTextField.text
                                userRegistrationRect.newUserDict["surname"] = userSurnameTextField.text
                                userRegistrationRect.newUserDict["age"] = parseInt(userAgeTextField.text)
                                //backend.addUser(JSON.stringify( userRegistrationRect.newUserDict))

                                userIDTextField.text = qsTr("")
                                userNameTextField.text = qsTr("")
                                userSurnameTextField.text = qsTr("")
                                userAgeTextField.text = qsTr("")
                                comboBoxUserType.currentIndex = -1
                            }

                        }
                    }

                }
            }
        }

        Rectangle {
            id: showRegisteredUser
            color: "#00ffffff"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: userRegistrationRect.bottom
            anchors.bottom: parent.bottom
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0

            ListModel{
                id: registeredUserModelList
            }

            Component {
                id: showUserDelegate
                Item {
                    width: grid.cellWidth; height: grid.cellHeight
                    Column {
                        anchors.fill: parent
                        Image { source: portrait; anchors.horizontalCenter: parent.horizontalCenter }
                        Text { text: name; anchors.horizontalCenter: parent.horizontalCenter }
                    }
                }
            }



            GridView {
                id: gridView
                anchors.fill: parent
                clip: true
                model: registeredUserModelList
                delegate: showUserDelegate
                cellHeight: 70
                cellWidth: 70


                populate: Transition {
                    NumberAnimation { properties: "x,y"; duration: 500 }
                }

                add: Transition {
                    NumberAnimation { properties: "x,y"; duration: 500 }
                }



            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:5}D{i:7}D{i:6}D{i:4}D{i:9}D{i:11}D{i:10}
D{i:8}D{i:13}D{i:15}D{i:14}D{i:12}D{i:17}D{i:19}D{i:18}D{i:16}D{i:21}D{i:23}D{i:28}
D{i:31}D{i:22}D{i:20}D{i:3}D{i:2}D{i:33}D{i:34}D{i:39}D{i:32}D{i:1}
}
##^##*/
