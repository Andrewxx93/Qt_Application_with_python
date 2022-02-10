import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15


Button{
    id: btnLeftMenu
    text: qsTr("Left Menu Text")
    //CUSTOM PROPERTIES
    property url  btnIconSource: "../../images/svg_images/home_icon.svg"
    property color btnColorDefault: "#1c1d20"
    property color  btnColorMouseOver: "#23272e"
    property color bntColorClicked: "#00a1f1"
    property int iconWidth: 18
    property int iconHeight: 18
    property int leftMarginCustom: 26
    property color activeMenuColor: "#55aaff"
    //property color activeMenuColorRigth: "#2c313c"
    property bool isActiveMenu: false

    QtObject{
        id: internal


        // MOUSE OVER AND CLICK CHANGE COLOR
        property var dynamicColor: if(btnLeftMenu.down){
                                        btnLeftMenu.down ? bntColorClicked : btnColorDefault

                                   }
                                   else{
                                       btnLeftMenu.hovered ? btnColorMouseOver : btnColorDefault
                                   }
    }

    implicitWidth: 250
    implicitHeight: 70

    background: Rectangle{
        id: bgBtn
        color: internal.dynamicColor

        Rectangle{
               anchors{
                    top: parent.top
                    left: parent.left
                    bottom: parent.bottom

               }

               color: activeMenuColor
               width: 4
               visible: isActiveMenu

        }

//        Rectangle{
//               id: IDactiveMenuColorRight
//               anchors{
//                    top: parent.top
//                    right: parent.right
//                    bottom: parent.bottom

//               }

//               color: activeMenuColorRigth
//               width: 5
//               visible: isActiveMenu

//        }


    }

    contentItem: Item{
        anchors.fill:parent
        id: item1
        Image{
            id: iconBtn
            source: btnIconSource
            anchors.leftMargin: leftMarginCustom
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            sourceSize.width: iconWidth
            sourceSize.height: iconHeight
            width: iconWidth
            height: iconHeight
            fillMode: Image.PreserveAspectFit
            visible: false
            antialiasing: true
        }

        ColorOverlay{
            anchors.fill: iconBtn
            source: iconBtn
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true
            width: iconWidth
            height: iconHeight

        }

        Text{
            color: "#ffffff"
            text: btnLeftMenu.text
            font: btnLeftMenu.font
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 75

        }


    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:1.75;height:60;width:250}D{i:1}
}
##^##*/
