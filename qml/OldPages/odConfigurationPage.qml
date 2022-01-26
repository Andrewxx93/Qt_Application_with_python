import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15


Rectangle {
    id: odConfigurationPage
    color: "#2c313c"
    anchors{
        //left:leftMenu.right
        right: parent.right
        top: parent.top
        bottom: parent.bottom
        rightMargin: 0
        leftMargin: 0
        bottomMargin: 25
        topMargin: 0
    }

    Rectangle {
        id: gymsLoaderContainer
        height: 150
        color: "#00ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Label {
            id: labelGyms
            height: 40
            text: qsTr("GYMS")
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

        Loader{
            id: gymsLoader
            clip: true
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: labelGyms.bottom
            anchors.bottom: parent.bottom
            source: "gyms.qml"
            anchors.rightMargin: 0
            anchors.leftMargin: 20
            anchors.bottomMargin: 0
            anchors.topMargin: 0



        }

    }

    Rectangle {
        id: roomsLoaderContainer
        height: 150
        color: "#00ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: gymsLoaderContainer.bottom

        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0


        Label {
            id: labelRooms
            height: 40
            color: "#ffffff"
            text: qsTr("ROOMS")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 20
            anchors.rightMargin: 0
            anchors.topMargin: 0
            font.pointSize: 12
        }

        // Loader {
        //     id: roomsLoader
        //     clip: true
        //     anchors.left: parent.left
        //     anchors.right: parent.right
        //     anchors.top: labelRooms.bottom
        //     anchors.bottom: parent.bottom
        //     source: "rooms.qml"
        //     anchors.bottomMargin: 0
        //     anchors.leftMargin: 20
        //     anchors.rightMargin: 0
        //     anchors.topMargin: 0
        // }

    }

    Rectangle {
        id: devicesLoaderContainer
        height: 150
        color: "#00ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: roomsLoaderContainer.bottom
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: 0
        Label {
            id: labelDevices
            height: 40
            color: "#ffffff"
            text: qsTr("DEVICES")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 20
            anchors.topMargin: 0
            anchors.rightMargin: 0
            font.pointSize: 12
        }

        // Loader {
        //     id: devicesLoader
        //     anchors.left: parent.left
        //     anchors.right: parent.right
        //     anchors.top: labelDevices.bottom
        //     anchors.bottom: parent.bottom
        //     source: "devices.qml"
        //     anchors.bottomMargin: 0
        //     clip: true
        //     anchors.leftMargin: 20
        //     anchors.topMargin: 0
        //     anchors.rightMargin: 0
        // }

    }



}


/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}D{i:2}D{i:4}D{i:3}D{i:1}
D{i:6}D{i:7}D{i:5}D{i:9}D{i:10}D{i:8}
}
##^##*/
