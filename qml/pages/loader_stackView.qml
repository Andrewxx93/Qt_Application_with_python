import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15



    Rectangle {
        id: loaderStackViewContentPage
        color: "#2c313c"
        anchors{
            left:leftMenu.right
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            rightMargin: 0
            leftMargin: 0
            bottomMargin: 25
            topMargin: 0
        }

        Loader{
            id: mainLoader
            anchors.fill: loaderStackViewContentPage
            source: "stackViewPage.qml"
        }



    }


/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:1.25;height:480;width:640}D{i:1}
}
##^##*/
