import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.15

ComboBox{
    id: comboBox

    property color colorDefault: "#ffffff"
    property color colorOnFocus: "#ffffff"
    property color colorMouseOver: "#ffffff"
    visible: true



    QtObject{
        id: internal

        property var dynamicColor: if(comboBox.focus){
                                       comboBox.hovered ? colorOnFocus : colorDefault
                                   }
                                   else{
                                       comboBox.hovered ? colorMouseOver : colorDefault
                                   }
    }

    implicitWidth: 300
    implicitHeight: 40
    background: Rectangle{
        color: internal.dynamicColor
        radius: 10
    }









}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.5}D{i:1}
}
##^##*/
