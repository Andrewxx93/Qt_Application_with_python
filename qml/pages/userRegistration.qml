import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.11
import QtQuick.Dialogs 1.2

import QtQuick.Controls 2.15
import "../controls"

Item {
    property var newUserDict: ({})

    MessageDialog {
        id: errorAddUserDialog
        title: "ERROR"
//        text: "CONFIGURATION NAME ALREADY PRESENT"

    }

    Rectangle {
        id: userRegistrationContainer

        color: "#2c313c"
        anchors.fill: parent

        Rectangle {
            id: userRegistrationRect
            height: 140
            color: "#00ffffff"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.topMargin: 10


            RowLayout {
                id: rowLayoutUserRegistration
                height: 80
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: registrationUserLabel.bottom
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
                            height: 40
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
                            height: 40
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
                            height: 40
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
                            height: 40
                            anchors.verticalCenter: parent.verticalCenter
                            horizontalAlignment: Text.AlignHCenter
                            placeholderText: "User Age"
                            implicitWidth: parent.width
                            validator: IntValidator{bottom:0; top:120}
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

                                    newUserDict["type"] = typeCode


                                }

                            }




                        }
                    }

                }

                Rectangle {
                    id: userTypeRect2
                    width: 200
                    height: 200
                    color: "#00ffffff"
                    Label {
                        id: userTypeLabel2
                        height: 20
                        color: "#ffffff"
                        text: ""
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
                        id: comboBoxTypeRect1
                        width: 200
                        color: "#00ffffff"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: userTypeLabel2.bottom
                        anchors.bottom: parent.bottom
                        ListModel {
                            id: userTypeModelList1
                            ListElement {
                                type: "User"
                                typeCode: 0
                            }

                            ListElement {
                                type: "Owner"
                                typeCode: 1
                            }

                            ListElement {
                                type: "Worker"
                                typeCode: 2
                            }

                            ListElement {
                                type: "Trainer"
                                typeCode: 3
                            }
                        }

                        CustomButton {
                            id: customButton
                            x: -40
                            height: 40
                            text: "Add User"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.right: parent.right

                            anchors.centerIn: parent.Center
                            anchors.leftMargin: 0
                            onClicked: {

                                                newUserDict["userID"] = userIDTextField.text
                                                newUserDict["name"] = userNameTextField.text
                                                newUserDict["surname"] = userSurnameTextField.text
                                                newUserDict["age"] = parseInt(userAgeTextField.text)
                                                backend.addUser(JSON.stringify( userRegistrationRect.newUserDict))
                                                print("Aggiunta nuovo utente")


                                                userIDTextField.text = qsTr("")
                                                userNameTextField.text = qsTr("")
                                                userSurnameTextField.text = qsTr("")
                                userAgeTextField.text = qsTr("")
                                comboBoxUserType.currentIndex = -1

                            }
                            anchors.topMargin: 10
                            anchors.rightMargin: 0
                        }
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 0
                        anchors.topMargin: 0
                        anchors.rightMargin: 0
                    }
                    Layout.fillWidth: true
                    Layout.maximumWidth: 200
                    Layout.fillHeight: true
                    Layout.preferredWidth: 100
                }
            }

            Rectangle {
                id: registrationUserLabel
                height: 40
                color: "#00ffffff"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.leftMargin: 0
                Label {
                    color: "#ffffff"
                    text: "Users Registration"
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 12
                    anchors.leftMargin: 10
                    font.bold: true
                }
                anchors.rightMargin: 0
                anchors.topMargin: 0
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

            //            Component {
            //                id: showUserDelegate
            //                Item {
            //                    width: gridView.cellWidth; height: gridView.cellHeight
            //                    Column {
            //                        anchors.fill: parent
            ////                        Image { source: portrait; anchors.horizontalCenter: parent.horizontalCenter }
            //                        Rectangle{
            //                            width: 60
            //                            height: 60
            //                            color: "blue"

            //                        Text { text: name; anchors.horizontalCenter: parent.horizontalCenter }
            //                        }
            //                    }
            //                }
            //            }



            //            GridView {
            //                id: gridView
            //                anchors.fill: parent
            //                clip: true
            //                model: registeredUserModelList
            //                delegate: showUserDelegate
            //                cellHeight: 70
            //                cellWidth: 70


            //                populate: Transition {
            //                    NumberAnimation { properties: "x,y"; duration: 500 }
            //                }

            //                add: Transition {
            //                    NumberAnimation { properties: "x,y"; duration: 500 }
            //                }



            //            }


            RowLayout {
                id: rowLayoutUserView

                height: 30
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: activeUserRect.bottom
                Rectangle {
                    id: userIDRect1
                    width: 200
                    height: 200
                    color: "#00ffffff"
                    Label {
                        id: userIDLabel1
                        height: 20
                        color: "#ffffff"
                        text: "User ID"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 0
                        anchors.topMargin: 10
                        anchors.rightMargin: 0
                    }
                    Layout.fillWidth: true
                    Layout.maximumWidth: 200
                    Layout.fillHeight: true
                    Layout.preferredWidth: 100
                }

                Rectangle {
                    id: userNameRect1
                    width: 200
                    height: 200
                    color: "#00ffffff"
                    Label {
                        id: userNameLabel1
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
                    Layout.fillWidth: true
                    Layout.maximumWidth: 200
                    Layout.fillHeight: true
                    Layout.preferredWidth: 100
                }

                Rectangle {
                    id: userSurnameRect1
                    width: 200
                    height: 200
                    color: "#00ffffff"
                    Label {
                        id: userSurnameLabel1
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
                    Layout.fillWidth: true
                    Layout.maximumWidth: 200
                    Layout.fillHeight: true
                    Layout.preferredWidth: 100
                }

                Rectangle {
                    id: userAgeRect1
                    width: 200
                    height: 200
                    color: "#00ffffff"
                    Label {
                        id: userAgeLabel1
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
                    Layout.fillWidth: true
                    Layout.maximumWidth: 200
                    Layout.fillHeight: true
                    Layout.preferredWidth: 100
                }

                Rectangle {
                    id: userTypeRect1
                    width: 200
                    height: 200
                    color: "#00ffffff"
                    Label {
                        id: userTypeLabel1
                        height: 20
                        color: "#ffffff"
                        text: "Type"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 0
                        anchors.topMargin: 10
                        anchors.rightMargin: 0
                    }
                    Layout.fillWidth: true
                    Layout.maximumWidth: 200
                    Layout.fillHeight: true
                    Layout.preferredWidth: 100
                }

                Rectangle {
                    id: userTypeRect3
                    width: 200
                    height: 200
                    color: "#00ffffff"
                    Label {
                        id: userTypeLabel3
                        height: 20
                        color: "#ffffff"
                        text: ""
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 0
                        anchors.topMargin: 10
                        anchors.rightMargin: 0
                    }
                    Layout.fillWidth: true
                    Layout.maximumWidth: 200
                    Layout.fillHeight: true
                    Layout.preferredWidth: 100
                }
                implicitHeight: 100
                anchors.leftMargin: 0
                anchors.topMargin: 10
                anchors.rightMargin: 0
            }

            Component {
                id: showUserDelegate
                RowLayout {
                    id: rectangle
                    height: 40
                    width: parent.width
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: 0
                    Rectangle{
                        Layout.preferredWidth: 100
                        Layout.maximumWidth: 200
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        color:"#00ff0000"
                        radius: 10
                        border.color: "#ffffff"
                        Label{ color: "#ffffff"; text: userID; anchors.fill: parent ;horizontalAlignment: Text.AlignHCenter ;verticalAlignment: Text.AlignVCenter}
                    }
                    Rectangle{
                        Layout.preferredWidth: 100
                        Layout.maximumWidth: 200
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        color:"#00ff0000"
                        border.color: "#ffffff"
                        radius: 10
                        Label{ color: "#ffffff"; text: name; anchors.fill: parent ;horizontalAlignment: Text.AlignHCenter ;verticalAlignment: Text.AlignVCenter}
                    }
                    Rectangle{
                        Layout.preferredWidth: 100
                        Layout.maximumWidth: 200
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        color:"#00ff0000"
                        border.color: "#ffffff"
                        radius: 10
                        Label{ color: "#ffffff"; text: surname; anchors.fill: parent ;horizontalAlignment: Text.AlignHCenter ;verticalAlignment: Text.AlignVCenter}
                    }
                    Rectangle{
                        Layout.preferredWidth: 100
                        Layout.maximumWidth: 200
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        color:"#00ff0000"
                        border.color: "#ffffff"
                        radius: 10
                        Label{ color: "#ffffff"; text: age; anchors.fill: parent ;horizontalAlignment: Text.AlignHCenter ;verticalAlignment: Text.AlignVCenter}
                    }
                    Rectangle{
                        Layout.preferredWidth: 100
                        Layout.maximumWidth: 200
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        color:"#00ff0000"
                        border.color: "#ffffff"
                        radius: 10
                        Label{ color: "#ffffff"; text: type; anchors.fill: parent ;horizontalAlignment: Text.AlignHCenter ;verticalAlignment: Text.AlignVCenter}
                    }
                    Rectangle{
                        id: rectangle1
                        Layout.preferredWidth: 100
                        Layout.maximumWidth: 200
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        color:"#00000000"
                        CustomRemoveButton{
                            width: 40
                            height: 40
                            text: "X"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            onClicked: {
                                registeredUserModelList.remove(index)
                            }




                        }
                    }




                }
            }

            ListView{
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: rowLayoutUserView.bottom
                anchors.bottom: parent.bottom
                anchors.rightMargin: 0
                anchors.leftMargin: 10
                anchors.bottomMargin: 0
                anchors.topMargin: 10
                model: registeredUserModelList
                delegate: showUserDelegate
                spacing: 10
                clip: true



            }

            Rectangle {
                id: activeUserRect
                height: 40
                color: "#00ffffff"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.leftMargin: 0
                anchors.topMargin: 0
                anchors.rightMargin: 0
                Label{
                    color: "#ffffff"
                    text: "Active Users"
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 20
                    font.bold: true
                    font.pointSize: 12

                }
            }





        }
    }


    Connections{
        target: backend
        function onUserList(idx,data){
            if(idx === 0){
                print("Error in adding new user.")
                errorAddUserDialog.text = data['error']
                errorAddUserDialog.visible = true


            }else if (idx === 1){
                registeredUserModelList.append(data)

            }else if (idx === 2){
                registeredUserModelList.clear()
                registeredUserModelList.append(data)
            }

        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}D{i:6}D{i:8}D{i:7}D{i:5}D{i:10}D{i:12}
D{i:11}D{i:9}D{i:14}D{i:16}D{i:15}D{i:13}D{i:18}D{i:20}D{i:19}D{i:17}D{i:23}D{i:25}
D{i:30}D{i:24}D{i:22}D{i:34}D{i:36}D{i:41}D{i:35}D{i:33}D{i:4}D{i:43}D{i:42}D{i:3}
D{i:45}D{i:48}D{i:47}D{i:50}D{i:49}D{i:52}D{i:51}D{i:54}D{i:53}D{i:56}D{i:55}D{i:58}
D{i:57}D{i:46}D{i:59}D{i:73}D{i:75}D{i:74}D{i:44}D{i:2}D{i:76}
}
##^##*/
