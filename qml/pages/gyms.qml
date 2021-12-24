import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15


Item {

    GridView{
        id: gridView
        anchors.fill: parent

        clip: true
        model: gymModelList
        cellHeight: 120
        cellWidth: 120
        delegate: RowLayout{
            id: layout
            Rectangle{
                id: gymRectangle
                property var gymStatus: status
                width: 100
                height: 100
                radius: 10

                Text{
                     id: gym
                     property var gymName: name
                     color: "#000000"
                     text: name
                     font.bold: true
                     font.pointSize: 10

                     anchors.centerIn: parent
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        selectBackendOperation(gym.gymName)
                        if(gym.gymName ==="+"){
                            popup.open()
                        }
                    }
                }

                Popup {
                       id: popup
                       x: 100
                       y: 100
                       width: 200
                       height: 300
                       modal: true
                       focus: true
                       closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
                       contentItem: Text {
                           id: popupText
                           text: qsTr("text")
                       }
                   }



                QtObject{
                    property var statusColor: if(gymRectangle.gymStatus === "fulloperative"){
                                                gymRectangle.color = "green"
                                              }
                                              else if(gymRectangle.gymStatus === "closed"){
                                                gymRectangle.color = "gray"
                                              }
                                              else if(gymRectangle.gymStatus === "problems"){
                                                gymRectangle.color = "orange"
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
