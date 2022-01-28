import QtQuick 2.15
import QtQuick.Controls 2.15


ComboBox{
    id: comboBox

    property color colorDefault: "#282c34"
    property color colorOnFocus: "#242831"
    property color colorMouseOver: "#2b2f38"


    QtObject{
        id: internal

        property var dynamicColor: if(comboBox.focus){
                                       comboBox.hovered ? colorOnFocus : colorDefault
                                   }
                                   else{
                                       comboBox.hovered ? colorMouseOver : colorDefault
                                   }
    }

//    delegate: ItemDelegate {
//            width: comboBox.width

//            contentItem: Text {
//                text : model.name
//                color: comboBox.color
//                font: comboBox.font
//                elide: Text.ElideRight
//                verticalAlignment: Text.AlignVCenter
//            }


//        }

    indicator: Canvas {
            id: canvas
            x: comboBox.width - width - comboBox.rightPadding
            y: comboBox.topPadding + (comboBox.availableHeight - height) / 2
            width: 12
            height: 8
            contextType: "2d"

            Connections {
                target: comboBox
                function onPressedChanged() { canvas.requestPaint(); }
            }

            onPaint: {
                context.reset();
                context.moveTo(0, 0);
                context.lineTo(width, 0);
                context.lineTo(width / 2, height);
                context.closePath();
                context.fillStyle = comboBox.pressed ? "00ff00" : "#81848c";//#81848c
                context.fill();
            }
        }

    contentItem: Text {
           leftPadding: 10
           rightPadding: comboBox.indicator.width + comboBox.spacing

           text: comboBox.displayText
           font: comboBox.font
           color: "#ffffff"
           verticalAlignment: Text.AlignVCenter
           elide: Text.ElideRight
       }

       background: Rectangle {
           implicitWidth: 120
           implicitHeight: 40
           color: internal.dynamicColor

           border.color: comboBox.pressed ? "#81848c" : colorDefault  //#81848c
           border.width: comboBox.visualFocus ? 2 : 1
           radius: 2
       }


       popup: Popup {
               y: comboBox.height - 1
               width: comboBox.width
               implicitHeight: contentItem.implicitHeight
               padding: 1

               contentItem: ListView {
                   clip: true
                   implicitHeight: contentHeight
                   model: comboBox.popup.visible ? comboBox.delegateModel : null
                   currentIndex: comboBox.highlightedIndex

                   ScrollIndicator.vertical: ScrollIndicator { }
               }

               background: Rectangle {
                   color: "#81848c"
                   border.color: "#495163"
                   radius: 2


               }
           }



}


