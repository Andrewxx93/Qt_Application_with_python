import QtQuick 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12



Rectangle{
    id: timePickerRect
    property string timeValue: ""

    color: "#00ffffff"
    Layout.preferredWidth: 0
    RowLayout{
        anchors.fill: parent
        Rectangle{
            width: 140
            Layout.preferredWidth: 120
            Layout.fillHeight: true
            Layout.fillWidth: true
            color : "#00ffffff"
            CustomTextField{
                id: timePickerTextField
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 8
                placeholderText: "HH:MM:SS"

                validator: RegExpValidator { regExp: /^(?:[01]?\d|2[0-3])(?::[0-5]\d){1,2}(?::[0-5]\d){1,2}$/ }
                focus: true
                inputMethodHints: Qt.ImhDigitsOnly

                onEditingFinished: {
                    timePickerRect.timeValue=timePickerTextField.text
                }

                onAccepted: {
                    print("Il testo accettato e': ",timePickerTextField.text)

                }

             }

        }

//        Rectangle {
//            id: rectangle

//            color: "#00ffff00"
//            Layout.preferredWidth: 80
//            Layout.fillHeight: true
//            Layout.fillWidth: true
//            CustomButton{
//                id: sendTime
//                anchors.fill: parent
//                onClicked: {
//                    if (hourTextField.text <=23 & timePickerTextField.text<=59){
//                        console.log(hourTextField.text,minutesTextField.text)
//                        /////////////////////////////////////77
//                        //Update time here
//                    }

//                    else
//                        console.log("Invalid Selection")
//                }
//            }
//        }

    }



}



/*##^##
Designer {
    D{i:0;formeditorZoom:4}D{i:3}D{i:2}D{i:1}
}
##^##*/
