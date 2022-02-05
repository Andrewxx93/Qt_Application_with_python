import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Item {
    width: 1000
    height: 580
    visible: true

    Rectangle {
        id: contentFrame
        color: "#fcaf3e"
        anchors.fill: parent

        Rectangle {
            id: gridFrame
            height: 200
            color: "#ffffff"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0


            ListModel {
                id: fruitModel

                ListElement {
                    name: "Apple"
                    cost: 2.45
                    attributes: [
                        ListElement { description: "Core" },
                        ListElement { description: "Deciduous" }
                    ]
                }
                ListElement {
                    name: "Orange"
                    cost: 3.25
                    attributes: [
                        ListElement { description: "Citrus" }
                    ]
                }
                ListElement {
                    name: "Banana"
                    cost: 1.95
                    attributes: [
                        ListElement { description: "Tropical" },
                        ListElement { description: "Seedless" }
                    ]
                }
            }


              ListView {
                  anchors.fill: parent
                  model: fruitModel
                  delegate: fruitDelegate
                  spacing: 10
              }
          }

                Component {
                    id: fruitDelegate
                    Row {
                        spacing: 10
                        Rectangle{
                        id:rectModel
                        height: 30
                        width: 80
                        color: "green"
                        Text {
                            anchors.centerIn: parent
                            id: something
                            text: name
                        }
                        }

                    }
                }

                Button {
                    id: btnNewElem
                    x: 338
                    y: 333
                    text: qsTr("Button")
                    onClicked: {pippo.addNewElement('ciao')}
                }







        }

    Connections {
    target: pippo
    function onAddElem(pos,data){
        fruitModel.insert(pos,data)
        }
    }


    }




/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:3}D{i:7}D{i:2}D{i:8}D{i:12}D{i:1}D{i:13}
}
##^##*/
