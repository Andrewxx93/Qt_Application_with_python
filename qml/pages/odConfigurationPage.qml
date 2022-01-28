import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15


Rectangle {
    id: odConfigurationPage
    color: "#2c313c"
    property string gymName: ""
    property string roomName: "Cardio"


    anchors{
        right: parent.right
        top: parent.top
        bottom: parent.bottom
        rightMargin: 0
        leftMargin: 0
        bottomMargin: 25
        topMargin: 0
    }
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    // ROOM






    Rectangle {
        id: gymsContainer
        height: parent.height/3
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


        Item {
            id: gymItem
            anchors.top : labelGyms.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.rightMargin: 0
            anchors.leftMargin: 20
            anchors.topMargin: 10

            ListModel{
                id: gymModelList

            }

            GridView{
                id: gymGridView
                anchors.fill: parent
                clip: true
                model: gymModelList
                delegate: gymDelegate
                cellHeight: 120
                cellWidth: 120



                populate: Transition {
                    NumberAnimation { properties: "x,y"; duration: 500 }
                }

                add: Transition {
                    NumberAnimation { properties: "x,y"; duration: 500 }
                }


                Component.onCompleted: backend.loadGymsStartup()

            }

            Component {

                id: gymDelegate
                Row {
                    spacing: 10
                    Rectangle{
                        id: gymRectModel

                        height: 100
                        width: 100
                        color: status
                        Text {
                            anchors.centerIn: parent
                            id: something
                            text: name
                        }





                        MouseArea {
                            id: gymMouseArea
                            anchors.fill: parent
                            //The first parameter is the gym name, the second parameter will be used to select the room
                            onClicked:  {
                                odConfigurationPage.gymName = name
                                backend.retrieveData(odConfigurationPage.gymName,'None')
                            }


                        }

                        QtObject{
                            id: internalGym
                            property color gymColorStatus: if(gymMouseArea.pressed){
                                                                gymRectModel.border.color = "white"
                                                               console.log()
                                                           }
                                                            else{
                                                                 gymRectModel.border.color = status
                                                           }


                                 }




                    }

                }


            }

            ////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////
            // If necessary, this function allows to add a new gym when the item whit name + is clicked


            //    function selectBackendOperation(gymName){
            //            if(gymName === '+'){
            //                backend.addNewGym(gymName)

            //            }else{
            //                backend.selectGym(gymName)


            //            }


            //    }

            ////////////////////////////////////////////////////////////




        }




    }

    Rectangle {
        id: roomsContainer
        height: parent.height/3
        color: "#00ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: gymsContainer.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Label {
            id: labelRoom
            height: 40
            text: qsTr("ROOMS")
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


        Item {
            id: roomItem
            anchors.top : labelRoom.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.rightMargin: 0
            anchors.leftMargin: 20
            anchors.topMargin: 0

            ListModel{
                id: roomModelList

            }

            GridView{
                id: roomGridView
                anchors.fill: parent
                clip: true
                model: roomModelList
                delegate: roomDelegate
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

                id: roomDelegate
                Row {
                    spacing: 10
                    Rectangle{
                        id:roomRectModel

                        height: 100
                        width: 100
                        color: status
                        Text {
                            anchors.centerIn: parent
                            id: something
                            text: name

                        }


                        MouseArea {
                            id: roomMouseArea
                            anchors.fill: parent
                            //The first parameter is the gym name, the second parameter will be used to select the room
                            onClicked:  {
                                odConfigurationPage.roomName = name
                                backend.retrieveData(odConfigurationPage.gymName,odConfigurationPage.roomName)


                            }


                        }

                                                    QtObject{
                                                        id: internalRoom
                                                        property color gymColorStatus: if(roomMouseArea.pressed){
                                                                                           roomRectModel.border.color = "white"
                                                                                       }
                                                                                       else{
                                                                                           roomRectModel.border.color = status
                                                                                       }


                                                    }




                    }

                }


            }

            ////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////
            // If necessary, this function allows to add a new gym when the item whit name + is clicked


            //    function selectBackendOperation(gymName){
            //            if(gymName === '+'){
            //                backend.addNewGym(gymName)

            //            }else{
            //                backend.selectGym(gymName)


            //            }


            //    }

            ////////////////////////////////////////////////////////////




        }




    }

    Rectangle {
        id: devicesContainer
        height: parent.height/3
        color: "#00ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: roomsContainer.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        Label {
            id: labelDevice
            height: 40
            color: "#ffffff"
            text: qsTr("DEVICES")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.rightMargin: 0
            anchors.leftMargin: 20
            anchors.topMargin: 0
            font.pointSize: 12
        }

        Item {
            id: deviceItem
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: labelDevice.bottom
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.rightMargin: 0
            anchors.leftMargin: 20
            anchors.topMargin: 0
            ListModel {
                id: deviceModelList
            }

            GridView {
                id: deviceGridView
                anchors.fill: parent
                add: Transition {
                    NumberAnimation {
                        properties: "x,y"
                        duration: 500
                    }
                }
                populate: Transition {
                    NumberAnimation {
                        properties: "x,y"
                        duration: 500
                    }
                }
                model: deviceModelList
                clip: true
                cellWidth: 120
                cellHeight: 120
                delegate: deviceDelegate
            }

            Component {
                id: deviceDelegate
                Row {
                    spacing: 10
                    Rectangle {
                        id: deviceRectModel
                        width: 100
                        height: 100
                        color: status
                        Text {
                            id: deviceText
                            text: type
                            anchors.centerIn: parent
                        }

                        MouseArea {
                            id: deviceMouseArea
                            anchors.fill: parent
                            onClicked: {
                                console.log(description)
                                //backend.retrieveData(odConfigurationPage.gymName,'Spinning')


                            }
                        }


                                                    QtObject{
                                                        id: internalDevice
                                                        property color gymColorStatus: if(deviceMouseArea.pressed){
                                                                                           deviceRectModel.border.color = "white"
                                                                                       }
                                                                                       else{
                                                                                           deviceRectModel.border.color = status
                                                                                       }


                                                    }
                    }
                }
            }
        }
    }


    Connections{
        target: backend


        function onGymSig(gymList){
            gymModelList.clear()
            roomModelList.clear()

            gymModelList.append(gymList)

        }

        function onRoomSig(roomList){
            roomModelList.clear()
            deviceModelList.clear()
            console.log(roomList)
            roomModelList.append(roomList)
        }

        function onDeviceSig(deviceList){
            console.log(deviceList)
            deviceModelList.clear()
            deviceModelList.append(deviceList)
        }


    }


}


/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}D{i:2}D{i:4}D{i:5}D{i:10}
D{i:3}D{i:1}D{i:17}D{i:19}D{i:20}D{i:25}D{i:18}D{i:16}D{i:32}D{i:34}D{i:35}D{i:40}
D{i:33}D{i:31}D{i:46}
}
##^##*/
