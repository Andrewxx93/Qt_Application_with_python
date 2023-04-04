import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.0
import "../controls"



Item {
    id: itemMCC // MCC Machine Control Configuration
    property string gymName:  'None'
    property string roomName: 'None'
    property string machine1: 'None'
     property string machine2: 'None'
    property string viewGymName: 'None'
    property string viewRoomName: 'None'
    property string viewMachine: 'None'

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
            height: 140







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
                id: rowLayoutAdjacentSelection
                anchors.left: parent.left

                anchors.right: parent.right
                anchors.top: labelAdjacentContainer.bottom
                anchors.bottom: parent.bottom
                anchors.leftMargin: 20
                antialiasing: true
                anchors.rightMargin: 20
                anchors.bottomMargin: 10
                anchors.topMargin: 10
                // gyms model list loading
                Component.onCompleted: {
                    backend.pairList('None','None','None','None')
                }

                ListModel{
                    id: gymModelList

                }
                ListModel{
                    id: roomModelList


                }
                ListModel{
                    id: firstMachineModelList


                }
                ListModel{
                    id: secondMachineModelList


                }

                Rectangle {
                    id: rectangleGym
                    height: parent.height
                    color: "#00ffffff"
                    Layout.leftMargin: 0
                    clip: true
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
                        implicitWidth: parent.width
                        implicitHeight: 40
                        //In order to display the text on the ComboBox when selected
                        currentIndex: -1
                        textRole: 'name'
                        displayText: currentText

                        delegate: ItemDelegate {
                                width: parent.width
                                contentItem: Text {
                                    text : name
                                    elide: Text.ElideRight
                                    verticalAlignment: Text.AlignVCenter

                                }
                                onPressed: {
                                    itemMCC.gymName = name
                                    backend.pairList( itemMCC.gymName,'None','None','None')


                                }

                            }


                    }
                }


                Rectangle {
                    id: rectangleRoom
                    width: CustomComboBox.width
                    height: parent.height
                    color: "#00ffffff"
                    clip: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.fillWidth: true
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
                        implicitHeight: 40
                        //In order to display the text on the ComboBox when selected
                        currentIndex: -1
                        textRole: 'name'
                        displayText: currentText
                        delegate: ItemDelegate {
                                width: parent.width
                                contentItem: Text {
                                    text: name

                                }
                                onPressed: {
                                    itemMCC.roomName = name
                                    backend.pairList( itemMCC.gymName,itemMCC.roomName,'None','None')

                                }
                        }

                    }
                }

                Rectangle {
                    id: rectangleMachine1
                    width: CustomComboBox.width
                    height: parent.height
                    color: "#00ffffff"
                    clip: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.fillWidth: true
                    Label {
                        id: labelMachine1Selection
                        color: "#feffff"
                        text: "MACHINE-1"
                        anchors.top: parent.top
                        anchors.topMargin: 0
                    }

                    CustomComboBox {
                        id: machine1ComboBox
                        anchors.top: labelMachine1Selection.bottom
                        anchors.topMargin: 10
                        implicitWidth: parent.width
                        implicitHeight: 40
                        model: firstMachineModelList
                        //In order to display the text on the ComboBox when selected
                        currentIndex: -1
                        textRole: 'name'
                        displayText: currentText

                        delegate: ItemDelegate {
                            width: parent.width
                            contentItem: Text {
                                text: name

                            }
                            onPressed: {
                                itemMCC.machine1 = name
                                backend.pairList( itemMCC.gymName,itemMCC.roomName,itemMCC.machine1,'None')

                            }
                        }

                    }
                }

                Rectangle {
                    id: rectangleMachine2
                    width: CustomComboBox.width
                    height: parent.height
                    color: "#00ffffff"
                    clip: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.fillWidth: true
                    Label {
                        id: labelMachine2Selection
                        color: "#feffff"
                        text: "MACHINE-2"
                        anchors.top: parent.top
                        anchors.topMargin: 0
                    }

                    CustomComboBox {
                        id: machine2ComboBox
                        anchors.top: labelMachine2Selection.bottom
                        anchors.topMargin: 10
                        implicitWidth: parent.width
                        implicitHeight: 40
                        model: secondMachineModelList
                        //In order to display the text on the ComboBox when selected
                        currentIndex: -1
                        textRole: 'name'
                        displayText: currentText
                        delegate: ItemDelegate {
                        width: parent.width
                            contentItem: Text {
                                text: name

                            }
                            onPressed: {
                                itemMCC.machine2 = name

                            }
                        }
                    }
                }


                Rectangle {
                    id: rectangleMCCSendButton
                    width: CustomButton.width
                    height: parent.height
                    color: "#00ffffff"
                    clip: true
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
                        id: sendMCCButton
                        anchors.top: buttonSendLabel.bottom
                        anchors.topMargin: 10
                        width: parent.width
                        text: qsTr("Send Configuration")
                        onClicked:  {
                            backend.pairList( itemMCC.gymName,itemMCC.roomName,itemMCC.machine1,itemMCC.machine2)
                            itemMCC.resetCurrentIndex(0)
                        }



                    }
                }
            }


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

            RowLayout {
                id: rowLayoutAdjacentView
                height: 100
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: labelViewContainer.bottom
                anchors.topMargin: 10
                antialiasing: true
                anchors.rightMargin: 20
                anchors.leftMargin: 20
                ListModel {
                    id: gymModelView

                }

                ListModel {
                    id: roomModelView

                }

                ListModel {
                    id: pairMachineModelView

                }



                Rectangle {
                    id: rectangleGymView
                    height: parent.height
                    color: "#00ffffff"
                    clip: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    // gyms model list loading for the view of the paired machine
                    Component.onCompleted: {
                        backend.getAdjacency('None','None','None')
                    }
                    Label {
                        id: labelGymSelectionView
                        color: "#feffff"
                        text: "GYM"
                        anchors.top: parent.top
                        anchors.topMargin: 0
                    }

                    CustomComboBox {
                        id: gymComboBoxView
                        anchors.top: labelGymSelectionView.bottom
                        model: gymModelView
                        anchors.topMargin: 10
                        //In order to display the text on the ComboBox when selected
                        currentIndex: -1
                        textRole: 'name'
                        displayText: currentText
                        delegate: ItemDelegate {
                            width: parent.width
                            onPressed: {
                                pairMachineModelView.clear()
                                itemMCC.viewGymName = name
                                backend.getAdjacency( itemMCC.viewGymName,'None','None')



                            }
                            contentItem: Text {
                                text: name
                                elide: Text.ElideRight
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                        implicitWidth: parent.width
                        implicitHeight: 40
                    }
                    Layout.fillWidth: true
                    Layout.leftMargin: 0
                }

                Rectangle {
                    id: rectangleRoomView
                    width: CustomComboBox.width
                    height: parent.height
                    color: "#00ffffff"
                    clip: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Label {
                        id: labelRoomSelectionView
                        color: "#feffff"
                        text: "ROOM"
                        anchors.top: parent.top
                        anchors.topMargin: 0
                    }

                    CustomComboBox {
                        id: roomComboBoxView
                        anchors.top: labelRoomSelectionView.bottom
                        model: roomModelView
                        anchors.topMargin: 10
                        //In order to display the text on the ComboBox when selected
                        currentIndex: -1
                        textRole: 'name'
                        displayText: currentText
                        delegate: ItemDelegate {
                            width: parent.width
                            onPressed: {
                                itemMCC.viewRoomName = name
                                backend.getAdjacency( itemMCC.viewGymName,itemMCC.viewRoomName,'None')

                            }
                            contentItem: Text {
                                text: name
                            }
                        }
                        implicitWidth: parent.width
                        implicitHeight: 40
                    }
                    Layout.fillWidth: true
                }

                Rectangle {
                    id: rectangleMachineView
                    width: CustomComboBox.width
                    height: parent.height
                    color: "#00ffffff"
                    clip: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Label {
                        id: labelMachine1SelectionView
                        color: "#feffff"
                        text: "MACHINE"
                        anchors.top: parent.top
                        anchors.topMargin: 0
                    }

                    CustomComboBox {
                        id: machineComboBoxView
                        anchors.top: labelMachine1SelectionView.bottom
                        anchors.topMargin: 10
                        model: pairMachineModelView
                        //In order to display the text on the ComboBox when selected
                        currentIndex: -1
                        textRole: 'name'
                        displayText: currentText
                        delegate: ItemDelegate {
                            width: parent.width
                            onPressed: {
                                itemMCC.viewMachine = name
                                backend.getAdjacency( itemMCC.viewGymName,itemMCC.viewRoomName,itemMCC.viewMachine)

                            }
                            contentItem: Text {
                                text: name
                            }
                        }
                        implicitWidth: parent.width
                        implicitHeight: 40
                    }
                    Layout.fillWidth: true
                }

                Rectangle {
                    id: rectangleMCCShowAdjacency
                    width: CustomButton.width
                    height: parent.height
                    color: "#00ffffff"
                    clip: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.minimumWidth: 80
                    Layout.fillWidth: true
                    Layout.preferredWidth: 100
                    Layout.maximumWidth: 150
                    Label {
                        id: buttonShowAdiacency
                        color: "#feffff"
                        anchors.top: parent.top
                        anchors.topMargin: 0
                    }

                    CustomButton {
                        id: showMCCAdiacencyButton
                        width: parent.width
                        anchors.top: buttonShowAdiacency.bottom
                        anchors.topMargin: 10
                        text: qsTr("Clear View")
                        onClicked: {
                                itemMCC.resetCurrentIndex(1)

                        }
                    }

                }

            }

            Item {
                id: showAdjacencyView
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: rowLayoutAdjacentView.bottom
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.rightMargin: 0
                anchors.leftMargin: 20
                anchors.topMargin: 0

                ListModel{
                    id: adjModelList
                    ListElement {
                        name: "prova1"
                        status: "green"
                    }
                    ListElement {
                        name: "prova2"
                        status: "green"
                    }
                    ListElement {
                        name: "prova"
                        status: "green"
                    }
                    ListElement {
                        name: "prova1"
                        status: "green"
                    }
                    ListElement {
                        name: "prova2"
                        status: "green"
                    }
                    ListElement {
                        name: "prova"
                        status: "green"
                    }
                    ListElement {
                        name: "prova1"
                        status: "green"
                    }
                    ListElement {
                        name: "prova2"
                        status: "green"
                    }
                    ListElement {
                        name: "prova"
                        status: "green"
                    }
                    ListElement {
                        name: "prova1"
                        status: "green"
                    }
                    ListElement {
                        name: "prova2"
                        status: "green"
                    }
                    ListElement {
                        name: "prova"
                        status: "green"
                    }ListElement {
                        name: "prova1"
                        status: "green"
                    }
                    ListElement {
                        name: "prova2"
                        status: "green"
                    }
                    ListElement {
                        name: "prova"
                        status: "green"
                    }

                }

                GridView {
                    id: showAdjacencyGridView
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    clip: true
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0
                    model: adjModelList
                    delegate: adjDelegate
                    cellHeight: 120
                    cellWidth: 120



                    populate: Transition {
                        NumberAnimation { properties: "x,y"; duration: 500 }
                    }

                    add: Transition {
                        NumberAnimation { properties: "x,y"; duration: 500 }
                    }

                }

                Component {

                    id: adjDelegate
                    Row {
                        spacing: 10
                        Rectangle{
                            id: adjRectModel

                            height: 100
                            width: 100
                            color: status
                            Text {
                                anchors.centerIn: parent
                                id: something
                                text: name
                            }


                        }

                    }

                }
            }

        }
    }

    function resetCurrentIndex(selection){
        if (selection === 0) {
            gymComboBox.currentIndex = -1
            roomComboBox.currentIndex = -1
            machine1ComboBox.currentIndex = -1
            machine2ComboBox.currentIndex = -1
            itemMCC.gymName = 'None'
            itemMCC.roomName = 'None'
            itemMCC.machine1 = 'None'
            itemMCC.machine2 = 'None'
            console.log(itemMCC.gymName,itemMCC.roomName,itemMCC.machine1,itemMCC.machine2)
        }
        else if(selection ===1){
            gymComboBoxView.currentIndex = -1
            roomComboBoxView.currentIndex = -1
            machineComboBoxView.currentIndex = -1
            itemMCC.viewGymName = 'None'
            itemMCC.viewRoomName = 'None'
            itemMCC.viewMachine = 'None'

            console.log(itemMCC.viewGymName,itemMCC.viewRoomName,itemMCC.viewMachine)

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

        function onAdjSig(adjList){
            adjModelList.clear()
            adjModelList.append(adjList)

        }

    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:1.1;height:480;width:640}D{i:3}D{i:5}D{i:6}D{i:7}
D{i:8}D{i:10}D{i:11}D{i:9}D{i:15}D{i:16}D{i:14}D{i:20}D{i:21}D{i:19}D{i:25}D{i:26}
D{i:24}D{i:30}D{i:31}D{i:29}D{i:4}D{i:2}D{i:33}D{i:35}D{i:36}D{i:37}D{i:39}D{i:40}
D{i:38}D{i:44}D{i:45}D{i:43}D{i:49}D{i:50}D{i:48}D{i:54}D{i:55}D{i:53}D{i:34}D{i:57}
D{i:73}D{i:78}D{i:56}D{i:32}D{i:1}D{i:82}
}
##^##*/
