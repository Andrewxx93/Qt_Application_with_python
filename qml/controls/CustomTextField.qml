import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15



TextField{
    id: textField

    property color colorDefault: "#282c34"
    property color colorOnFocus: "#242831"
    property color colorMouseOver: "#2b2f38"
    property color errorColor: "red"
    property int errorCode: 0

    QtObject{
        id: internal
        property var dynamicColor:{
                if(textField.focus){
                    textField.hovered ? colorOnFocus : colorDefault
                }
                else{
                     textField.hovered ? colorMouseOver: colorDefault
                }

        }
        property var dynamicBorderColor: {
            if(textField.errorCode === 1){
                return errorColor
            }
            else{
                return colorDefault
            }
         }
    }

//    implicitWidth: 300
//    implicitHeight: 40
    placeholderText: qsTr("Type Something")
    color: "#ffffff"
    background: Rectangle{
        color: internal.dynamicColor
        radius: 10
        border.color : internal.dynamicBorderColor
    }

    selectByMouse: true
    selectedTextColor: "#ffffff"
    selectionColor: "#ff007f"
    placeholderTextColor: "#81848c"


}


