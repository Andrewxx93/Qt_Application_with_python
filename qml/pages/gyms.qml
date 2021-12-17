import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15


Item {
    GridView{
        id: gridView
        anchors.fill: parent
        model: gymModelList
        cellHeight: 150
        cellWidth: width/4
        delegate: RowLayout{
            id: layout
            Rectangle{

                width: 120
                height: 120
                color: "white"
                radius: 10

                Text{
                     id: gym
                     property var gymName: name
                     color: "#000000"
                     text: name

                     anchors.centerIn: parent
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        parent.color = 'red'
                        backend.selectGym(gym.gymName)
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
