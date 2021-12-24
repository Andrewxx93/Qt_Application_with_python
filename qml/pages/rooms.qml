import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15


Item {
    GridView{
        id: roomGridView
        anchors.fill: parent

        model: roomModelList
        cellHeight: 120
        cellWidth: 120
        delegate: RowLayout{
            id: roomLayout

            Rectangle{
                id: roomRectangle
                property var roomStatus: status
                width: 100
                height: 100
                color: "white"
                radius: 10
                Text{
                     id: room
                     color: "#000000"
                     property var roomName: name
                     text: name
                     font.bold: true
                     font.pointSize: 10
                     anchors.centerIn: parent
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        parent.color = 'green'
                        backend.selectRoom(room.roomName)


                    }
                }
                QtObject{
                    property var statusColor: if(roomRectangle.roomStatus === "fulloperative"){
                                                roomRectangle.color = "green"
                                              }
                                              else if(roomRectangle.roomStatus === "closed"){
                                                roomRectangle.color = "gray"
                                              }
                                              else if(roomRectangle.roomStatus === "problems"){
                                                roomRectangle.color = "orange"
                                              }
                }

            }
        }

        populate: Transition {
                NumberAnimation { properties: "x,y"; duration: 500 }
            }


    }

}





/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}
}
##^##*/
