import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15


Item {

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
                        //The first parameter is the gym name, the second parameter will be used to select the room
                        onClicked:  backend.retrieveData(name,None)


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


    Connections{
        target: backend

        function onLoadGyms(gym){

            gymModelList.append(gym)


        }
        function onAddGym(gym){
            gymModelList.append(gym)

        }


    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}D{i:2}
}
##^##*/
