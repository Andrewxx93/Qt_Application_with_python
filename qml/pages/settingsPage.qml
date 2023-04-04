import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    Rectangle {
        id: rectangle
        color: "#2c313c"
        anchors.fill: parent

        Label {
            id: projectName
            color: "#ffffff"
            text: qsTr("Smart Gym")
            anchors.top: parent.top
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 16
        }

        Label {
            id: label1
            color: "#ffffff"
            text: qsTr("Settings Page")
            anchors.top: projectName.bottom
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 20
            font.pointSize: 16
        }

        Label {
            id: label2
            color: "#ffffff"
            text: qsTr("Settings Page")
            anchors.top: label1.bottom
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.topMargin: 20
            font.pointSize: 16
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Label {
            id: label3
            color: "#ffffff"
            text: qsTr("Settings Page")
            anchors.top: label2.bottom
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.topMargin: 20
            font.pointSize: 16
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Label {
            id: label4
            color: "#ffffff"
            text: qsTr("Settings Page")
            anchors.top: label3.bottom
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.topMargin: 20
            font.pointSize: 16
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

}



/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:800}D{i:2}D{i:3}D{i:4}D{i:5}D{i:6}D{i:1}
}
##^##*/
