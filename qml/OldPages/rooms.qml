import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15


Item {

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


        Component.onCompleted: backend.loadRoom()

    }

    Component {

        id: roomDelegate
        Row {
                spacing: 10
                Rectangle{
                    id:rectModel

                    height: 100
                    width: 100
                    color: status
                    Text {
                          anchors.centerIn: parent
                          id: something
                          text: name
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked:  backend.selectRoom(name)

                    }




               }

        }


   }

////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
// If necessary, this function allows to add a new room when the item whit name + is clicked


//    function selectBackendOperation(roomName){
//            if(gymName === '+'){
//                backend.addNewRoom(roomName)

//            }else{
//                backend.selectRoom(roomName)


//            }


//    }

////////////////////////////////////////////////////////////


    Connections{
        target: backend

        function onLoadRoom(room){

            roomModelList.append(room)
            console.log(roomModelList.count)

        }
        function onAddRoom(room){
            roomModelList.append(room)

        }

    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}D{i:2}
}
##^##*/
