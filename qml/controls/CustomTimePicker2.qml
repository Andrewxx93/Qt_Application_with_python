import QtQuick 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12



Rectangle{
    id: timePickerRect
    color: "#00ffffff"
    width: timePickerRect.width
    height: timePickerRect.height

            CustomTextField{
                id: timePickerTextField
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 12
                placeholderText: "HH:MM"

                validator: RegExpValidator { regExp: /^(?:[01]?\d|2[0-3])(?::[0-5]\d){1,2}$/ }
                focus: true
                inputMethodHints: Qt.ImhDigitsOnly

                onAccepted: {
                    print("Il testo accettato e': ",timePickerTextField.text)

                }

             }




    }





