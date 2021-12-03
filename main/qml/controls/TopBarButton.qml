import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15


Button{
    id: btnTopBar
    //CUSTOM PROPERTIES
    property url  btnIconSource: "../../images/svg_images/minimize_icon.svg"
    property color btnColorDefault: "#1c1d20"
    property color  btnColorMouseOver: "#23272e"
    property color bntColorClicked: "#00a1f1"

    QtObject{
        id: internal
        // MOUSE OVER AND CLICK CHANGE COLOR
        property var dynamicColor: if(btnTopBar.down){
                                        btnTopBar.down ? bntColorClicked : btnColorDefault

                                   }
                                   else{
                                       btnTopBar.hovered ? btnColorMouseOver : btnColorDefault
                                   }
    }

    implicitWidth: 35
    implicitHeight: 35

    background: Rectangle{
        id: bgBtn
        color: internal.dynamicColor
        Image{
            id: iconBtn
            source: btnIconSource
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: 16
            width: 16
            fillMode: Image.PreserveAspectFit

        }

        ColorOverlay{
            anchors.fill: iconBtn
            source: iconBtn
            color: "#ffffff"
            antialiasing: false
        }


    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:16}D{i:1}
}
##^##*/
