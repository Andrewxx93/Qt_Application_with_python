import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15


Item {
    property color colorDefault: "#4891d9"
    property color colorMouseOver: "#55aaff"
    property color colorClicked: "#3f7ebd"

//    ListModel{
//        id: listModel
//        dynamicRoles: true
//        ListElement { name: "one"; page:"" }
//        ListElement { name: "two"; page:"" }
//        ListElement { name: "three"; page:"" }
//        ListElement { name: "four"; page:"" }
//        ListElement { name: "five"; page:"" }
//        ListElement { name: "six"; page:"" }
//        ListElement { name: "sevent"; page:"" }
//        ListElement { name: "eight"; page:"" }


//    }

    GridView{
        id: gridView
        anchors.fill: parent
        model: PersonModel
        cellHeight: 150
        cellWidth: width/4
//        delegate: Rectangle{
//            width: 100
//            height: 100
//            color: "white"
//            radius: 10
//            Text{
//                color: "#000000"
//                text: name
//                anchors.centerIn: parent
//            }

//        }
        delegate: RowLayout{
            id: layout
            Rectangle{
                width: 120
                height: 120
                color: "white"
                radius: 10
                Text{
                     color: "#000000"
                     text: name + " " + age
                     anchors.centerIn: parent
                }

            }



        }
        populate: Transition {
                NumberAnimation { properties: "x,y"; duration: 500 }
            }




    }

//    Component.onCompleted: {

//        listModel.append({"name":"nine","page":""})
//        listModel.append({"name":"ten","page":""})
//        listModel.append({"name":"eleven","page":""})
//        listModel.append({"name":"twelve","page":""})

//    }
//    Connections{
//        target: backend

//        function onAddElem(elem){
//            listModel.append(elem)
//        }
//    }
}





/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}
}
##^##*/
