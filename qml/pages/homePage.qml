import QtQuick 2.0
import QtQuick.Controls 2.15
import "../controls"
import QtQuick.Layouts 1.0


Item {
    Rectangle {
        id: rectangle
        color: "#2c313c"
        anchors.fill: parent

        Rectangle {
            id: rectangleTop
            height: 69
            color: "#495163"
            radius: 10
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 50
            anchors.leftMargin: 50
            anchors.topMargin: 40

            GridLayout {
                anchors.fill: parent
                anchors.rightMargin: 10
                anchors.leftMargin: 10
                rows: 1
                columns: 3

                CustomTextField{
                    id: textField
                    placeholderText: qsTr("Type your name")
                    Layout.fillWidth: true
                    Keys.onEnterPressed: {
                        backend.welcomeText(textField.text)
                    }
                    Keys.onReturnPressed: {
                        backend.welcomeText(textField.text)
                    }


                }

                CustomButton{
                    id: btnChangeName
                    text: "Change Name"
                    Layout.maximumWidth: 200
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 250
                    onClicked: {
                        backend.welcomeText(textField.text)
                    }


                }

                Switch {
                    id: switchHome
                    checked: true
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 68
                    // Change Show/Hide Frame
                    onToggled: {
                        backend.showHideRectangle(switchHome.checked)
                    }


                }
            }
        }

        Rectangle {
            id: rectangleVisible
            color: "#1d2128"
            radius: 10
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: rectangleTop.bottom
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 40
            anchors.rightMargin: 50
            anchors.topMargin: 10
            anchors.leftMargin: 50

            Label {
                id: labelTextName

                y: 8
                height: 25
                color: "#5c667d"
                text: qsTr("Welcome")
                anchors.left: parent.left
                anchors.right: parent.right
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: 10
                anchors.leftMargin: 10
                font.pointSize: 14
            }

            Label {
                id: labelDate
                y: 31
                height: 25
                color: "#55aaff"
                text: qsTr("Date")
                anchors.left: parent.left
                anchors.right: parent.right
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: 10
                anchors.leftMargin: 10
                font.pointSize: 12

            }

            Label {
                id: labelGymName
                y: 62
                height: 25
                color: "#ffffff"
                text: qsTr("Gym Name")
                anchors.left: parent.left
                anchors.right: parent.right
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 12
                anchors.rightMargin: 10
                anchors.leftMargin: 10
            }

            Label {
                id: labelRoomName
                x: 20
                y: 93
                height: 25
                color: "#ffffff"
                text: qsTr("Room Name")
                anchors.left: parent.left
                anchors.right: parent.right
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 12
                anchors.rightMargin: 10
                anchors.leftMargin: 10
            }

            GridLayout {
                anchors.fill: parent
                columns: 3
                anchors.rightMargin: 10
                CustomTextField {
                    id: addGym
                    placeholderText: qsTr("Add  Gym Name")
                    Keys.onReturnPressed: {
                        backend.jsonCreator(addGym.text,addRoom.text)
                    }
                    Layout.fillWidth: true
                    Keys.onEnterPressed: {
                        backend.jsonCreator(addGym.text,addRoom.text)
                    }
                }

                CustomButton {
                    id: btnSendValue
                    text: "Send"
                    Layout.preferredWidth: 250
                    Layout.maximumWidth: 200
                    onClicked: {
                        backend.jsonCreator(addGym.text,addRoom.text)
                    }
                    Layout.fillWidth: true
                    Layout.preferredHeight: 40
                }

                CustomTextField {
                    id: addRoom
                    placeholderText: qsTr("Add Room")
                    Layout.fillWidth: true
                }
                rows: 1
                anchors.leftMargin: 10
            }


        }
    }

    Connections{
        target: backend

        function onSetName(name){
            labelTextName.text = name

        }

        function onPrintTime(time){
            labelDate.text = time

        }

        function onIsVisible(isVisible){
            rectangleVisible.visible = isVisible
        }

        function onSetGymName(value){
            labelGymName.text = value
        }



    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:800}D{i:4}D{i:5}D{i:6}D{i:3}D{i:2}D{i:8}D{i:9}
D{i:10}D{i:11}D{i:13}D{i:14}D{i:15}D{i:12}D{i:7}D{i:1}D{i:16}
}
##^##*/
