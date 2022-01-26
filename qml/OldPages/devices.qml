import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15


Item {

    GridView{
        id: deviceGridView
        anchors.fill: parent

        clip: true
        model: deviceModelList

        cellHeight: 120
        cellWidth: 120
        delegate: RowLayout{
            id: deviceLayout

            Rectangle{
                id: deviceRectangle
                property var deviceStatus: status
                width: 100
                height: 100
                color: "white"
                radius: 10


                Text{
                     id: device
                     color: "#000000"
                     text: type + "\n\n" + shortDescription
                     font.bold: true
                     font.pointSize: 10
                     anchors.centerIn: parent


                }
                ToolTip.delay: 250
                ToolTip.visible: mouseArea.containsMouse
                ToolTip.text: qsTr("DeviceID: ") + deviceID + "\n\n" + longDescription


                MouseArea{
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked:{
                        backend.selectRoom(device.type)

                    }
                }

                QtObject{
                    property var statusColor: if(deviceRectangle.deviceStatus === "fulloperative"){
                                                deviceRectangle.color = "green"
                                              }
                                              else if(deviceRectangle.deviceStatus === "closed"){
                                                deviceRectangle.color = "gray"
                                              }
                                              else if(deviceRectangle.deviceStatus === "problems"){
                                                deviceRectangle.color = "orange"
                                              }
                }


            }




        }

        populate: Transition {
                NumberAnimation { properties: "x,y"; duration: 500 }
            }


    }

    function selectBackendOperation(gymName){
            if(gymName === '+'){
                   backend.addNewGym(gymName)
            }else{
                   backend.selectGym(gymName)
            }
    }


}





/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}
}
##^##*/
