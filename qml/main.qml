import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "controls"
import QtQuick.Dialogs 1.3

Window {
    id: mainWindow
    width: 1600
    height: 1100
//    visibility: "FullScreen"  //Capire perché crasha !!!!
    visible: true
    minimumWidth: 1000
    minimumHeight: 800
    color: "#00000000"
    title: qsTr("Owner DASHBOARD")

    // Remove title bar
    flags: Qt.Window | Qt.FramelessWindowHint

    //Properties
    property int windowStatus: 0   //If 0 the window is not maximized; if 1 it is showMaximized()
    property int windowMargin: 10

    // Text Edit properties

    property alias actualPage: stackView.currentItem   //this property loads the property in the current page inside the stackView item


    // Internal functions
    QtObject{
        id: internal

        function resetResizeBorders(isMaximized){
            // Resize visibility: if the window is maximized, isMaximized = false and vice-versa
            resizeLeft.visible = isMaximized
            resizeRight.visible = isMaximized
            resizeTop.visible = isMaximized
            resizeBottom.visible = isMaximized
            resizeWindow.visible = isMaximized

        }

        function maximizeRestore(){
            if(windowStatus == 0){
                mainWindow.showMaximized()
                windowStatus = 1
                windowMargin = 0
                // Resize visibility
                internal.resetResizeBorders(false)

                btnMaximizeRestore.btnIconSource = "../images/svg_images/restore_icon.svg"
            }
            else{
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10

                // Resize visibility
                internal.resetResizeBorders(true)


                btnMaximizeRestore.btnIconSource = "../images/svg_images/maximize_icon.svg"
            }
        }

        function ifMaximizeWindowRestore(){
            if(windowStatus == 1){
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10
                btnMaximizeRestore.btnIconSource = "../images/svg_images/maximize_icon.svg"

            }


        }
        function restoreMargins(){
            windowStatus = 0
            windowMargin = 10
            btnMaximizeRestore.btnIconSource = "../images/svg_images/maximize_icon.svg"


        }



    }
    Rectangle {
        id: bg
        visible: true
        color: "#2c313c"
        border.color: "#383e4c"
        border.width: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: windowMargin
        anchors.rightMargin: windowMargin
        anchors.topMargin: windowMargin
        anchors.bottomMargin: windowMargin
        z:1

        Rectangle {
            id: appContainer
            color: "#00000000"
            anchors.fill: parent
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            anchors.bottomMargin: 1
            anchors.topMargin: 1

            Rectangle {
                id: topBar
                height: 60
                color: "#1c1d20"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0

                ToggleButton {
                    onClicked: animationMenu.running = true
                }

                Rectangle {
                    id: topBarDescription
                    y:  28
                    height: 25
                    color: "#282c34"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 70
                    anchors.bottomMargin: 0

                    Label {
                        id: labelTopInfo
                        color: "#5f6a82"
                        text: qsTr("Home")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        verticalAlignment: Text.AlignVCenter
                        anchors.bottomMargin: 0
                        anchors.rightMargin: 300
                        anchors.leftMargin: 10
                        anchors.topMargin: 0
                    }

                    Label {
                        id: labelRightInfo
                        color: "#5f6a82"
                        //text: qsTr("| HOME")
                        anchors.left: labelTopInfo.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter
                        anchors.rightMargin: 10
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0
                        anchors.leftMargin: 0
                    }


                }

                Rectangle {
                    id: titleBar
                    height: 35
                    color: "#00000000"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 105
                    anchors.leftMargin: 70
                    anchors.topMargin: 0

                    DragHandler{
                        onActiveChanged: if(active){
                                             mainWindow.startSystemMove()
                                             internal.ifMaximizeWindowRestore()
                                         }

                    }


                    Image {
                        id: iconApp
                        width: 22
                        height: 22
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        source: "../images/svg_images/icon_app_top.svg"
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 5
                        anchors.topMargin: 0
                        fillMode: Image.PreserveAspectFit
                    }


                    Label {
                        id: label
                        color: "#c3cbdd"
                        text: qsTr("Owner Dashboard")
                        anchors.left: iconApp.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        verticalAlignment: Text.AlignVCenter
                        anchors.rightMargin: 0
                        font.pointSize: 10
                        anchors.leftMargin: 0

                    }




                }

                Row {
                    id: rowBtns
                    x: 70
                    width: 105
                    height: 35
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.rightMargin: 0

                    TopBarButton {
                        id: btnMinimize
                        onClicked: {
                            mainWindow.showMinimized()
                            internal.restoreMargins

                        }

                    }

                    TopBarButton {
                        id: btnMaximizeRestore
                        btnIconSource: "../images/svg_images/maximize_icon.svg"
                        onClicked: internal.maximizeRestore()
                    }

                    TopBarButton {
                        id: btnClose
                        bntColorClicked: "#f10000"
                        btnIconSource: "../images/svg_images/close_icon.svg"
                        onClicked: mainWindow.close()

                    }
                }
            }

            Rectangle {
                id: content
                color: "#00000000"

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: topBar.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: 0

                Rectangle {
                    id: leftMenu
                    width: 70
                    color: "#1c1d20"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    clip: true
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0

                    PropertyAnimation{
                        id: animationMenu
                        target: leftMenu
                        property: "width"
                        to: if(leftMenu.width == 70) return 270; else return 70;
                        duration: 500
                        easing.type: Easing.InOutQuint

                    }

                    Column {
                        id: columnMenus
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        clip: true
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 90
                        anchors.topMargin: 0

                        LeftMenuButton {
                            id: btnHome
                            width: leftMenu.width
                            text: qsTr("Home")

                            btnIconSource: Qt.resolvedUrl("../images/gym/gymHome.svg")

                            iconWidth: 55
                            iconHeight: 55
                            leftMarginCustom: 12
                            isActiveMenu: true
                            onClicked: {
                                btnHome.isActiveMenu = true
                                btnSettings.isActiveMenu = false
                                machineControl.isActiveMenu = false
                                specificRoomManagement.isActiveMenu = false
                                userRegistration.isActiveMenu = false
                                statistics.isActiveMenu = false
                                stackView.push(Qt.resolvedUrl("pages/odConfigurationPage.qml"))
                                labelTopInfo.text = qsTr("Home")
                                backend.updateContext('None')

                            }
                        }



                        LeftMenuButton {
                            id: machineControl
                            width: leftMenu.width
                            text: qsTr("Machine Control Configuration")
                            leftPadding: 8
                            btnIconSource: "../images/gym/machineControlConf.svg"
                            iconWidth: 55
                            iconHeight: 55
                            leftMarginCustom: 12

                            onClicked: {
                                btnHome.isActiveMenu = false
                                btnSettings.isActiveMenu = false
                                specificRoomManagement.isActiveMenu = false
                                userRegistration.isActiveMenu = false
                                machineControl.isActiveMenu = true
                                statistics.isActiveMenu = false
                                labelTopInfo.text = qsTr("Machine Control Configuration")
                                stackView.push(Qt.resolvedUrl("pages/machineControlConfiguration.qml"))

                            }


                        }
                        LeftMenuButton {
                            id: specificRoomManagement
                            width: leftMenu.width
                            text: qsTr("Specific Room Management")
                            btnIconSource: Qt.resolvedUrl("../images/gym/specificRoomManagement.svg")
                            iconWidth: 55
                            iconHeight: 55
                            leftMarginCustom: 12

                            onClicked: {
                                btnHome.isActiveMenu = false
                                btnSettings.isActiveMenu = false
                                specificRoomManagement.isActiveMenu = true
                                machineControl.isActiveMenu = false
                                userRegistration.isActiveMenu = false
                                statistics.isActiveMenu = false
                                labelTopInfo.text = qsTr("Specific Room Management")
                                stackView.push(Qt.resolvedUrl("pages/specificRoomManagementConf2.qml"))

                            }


                        }

                        LeftMenuButton {
                            id: userRegistration
                            width: leftMenu.width
                            text: qsTr("User Registration")
                            btnIconSource:Qt.resolvedUrl( "../images/gym/userRegistration.svg")
                            iconWidth: 55
                            iconHeight: 55
                            leftMarginCustom: 12
                            onClicked: {
                                btnHome.isActiveMenu = false
                                btnSettings.isActiveMenu = false
                                specificRoomManagement.isActiveMenu = false
                                userRegistration.isActiveMenu = true
                                machineControl.isActiveMenu = false
                                statistics.isActiveMenu = false
                                labelTopInfo.text = qsTr("User Registration")
                                stackView.push(Qt.resolvedUrl("pages/userRegistration.qml"))

                            }


                        }
                        LeftMenuButton {
                            id: statistics
                            width: leftMenu.width
                            text: qsTr("Machine Statistics")
                            btnIconSource:Qt.resolvedUrl( "../images/gym/stats.svg")
                            iconWidth: 55
                            iconHeight: 55
                            leftMarginCustom: 12
                            onClicked: {
                                btnHome.isActiveMenu = false
                                btnSettings.isActiveMenu = false
                                specificRoomManagement.isActiveMenu = false
                                userRegistration.isActiveMenu = false
                                machineControl.isActiveMenu = false
                                statistics.isActiveMenu = true
                                labelTopInfo.text = qsTr("Machine Statistics")
                                stackView.push(Qt.resolvedUrl("pages/statisticsPage.qml"))

                            }


                        }


                    }

                    LeftMenuButton {
                        id: btnSettings
                        width: leftMenu.width
                        text: qsTr("Settings")
                        anchors.bottom: parent.bottom
                        clip: true
                        anchors.bottomMargin: 25
                        iconWidth: 40
                        iconHeight: 40
                        leftMarginCustom: 18
                        btnIconSource: Qt.resolvedUrl("../images/svg_images/settings_icon.svg")
                        onClicked: {
                            btnHome.isActiveMenu = false
                            specificRoomManagement.isActiveMenu = false
                            machineControl.isActiveMenu = false
                            userRegistration.isActiveMenu = false
                            btnSettings.isActiveMenu = true
                            statistics.isActiveMenu = false
                            stackView.push(Qt.resolvedUrl("pages/sta.qml"))

                        }
                    }
                }

                Rectangle {
                    id: contentPages
                    color: "#00000000"
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    clip: true
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 25
                    anchors.topMargin: 0

                    StackView {
                        id: stackView
                        anchors.fill: parent
                        anchors.rightMargin: 0
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 0
                        anchors.topMargin: 0

                        initialItem: Qt.resolvedUrl("pages/odConfigurationPage.qml")

                    }
                }

                Rectangle {
                    id: rectangle
                    color: "#282c34"
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: contentPages.bottom
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0

//                    Component.onCompleted:{

//                        deviceConnectorStatus.color = "red"
//                        labelDeviceConnectorStatus.text = "disconnected"
//                        labelDeviceConnectorStatus.color = "red"


//                    }

                    Rectangle {
                        id: deviceConnectorStatus
                        //color: "#ffffff"
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 10
                        anchors.bottomMargin: 5
                        anchors.topMargin: 5
                        width :15
                    }
                    Label {
                        id: labelDeviceConnectorStatus
                        color: "#5f6a82"
                        text: qsTr("Device connector Status here")
                        anchors.left: deviceConnectorStatus.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        anchors.rightMargin: 30
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0
                        anchors.leftMargin: 10
                    }
                    MouseArea {
                        id: resizeWindow
                        x: 894
                        y: 11
                        width: 25
                        height: 25
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0
                        anchors.rightMargin: 0
                        cursorShape: Qt.SizeFDiagCursor

                        DragHandler{
                            target: null
                            onActiveChanged: if(active){
                                                 mainWindow.startSystemResize(Qt.RightEdge | Qt.BottomEdge)
                                             }

                        }

                        Image {
                            id: image
                            opacity: 0.5
                            anchors.fill: parent
                            source: "../images/svg_images/resize_icon.svg"
                            anchors.leftMargin: 5
                            anchors.topMargin: 5
                            sourceSize.height: 16
                            sourceSize.width: 16
                            fillMode: Image.PreserveAspectFit
                            antialiasing: false
                        }



                    }
                }
            }
        }
    }



    DropShadow{
        anchors.fill: bg
        horizontalOffset: 0
        verticalOffset: 0
        radius: 10
        samples: 16
        color: "#80000000"
        source: bg
        z: 0

    }

    MouseArea {
        id: resizeLeft
        width: 10
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        cursorShape: Qt.SizeHorCursor


        DragHandler{
            target: null
            onActiveChanged: if(active){
                                 mainWindow.startSystemResize(Qt.LeftEdge)
                             }

        }
    }

    MouseArea {
        id: resizeRight
        width: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        cursorShape: Qt.SizeHorCursor


        DragHandler{
            target: null
            onActiveChanged: if(active){
                                 mainWindow.startSystemResize(Qt.RightEdge)
                             }

        }
    }


    MouseArea {
        id: resizeBottom
        height: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        cursorShape: Qt.SizeVerCursor


        DragHandler{
            target: null
            onActiveChanged: if(active){
                                 mainWindow.startSystemResize(Qt.BottomEdge)
                             }

        }
    }



    MouseArea {
        id: resizeTop
        height: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        cursorShape: Qt.SizeVerCursor


        DragHandler{
            target: null
            onActiveChanged: if(active){
                                 mainWindow.startSystemResize(Qt.TopEdge)
                             }

        }
    }

    Connections{
        target: backend

        function onPrintTime(time){
             labelRightInfo.text = time
       }

        function onConnStatus(data){
                deviceConnectorStatus.color = data.status
                labelDeviceConnectorStatus.text = data.description
            }

    }





}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}D{i:1}D{i:5}D{i:7}D{i:8}D{i:6}D{i:10}D{i:11}D{i:12}D{i:9}
D{i:14}D{i:15}D{i:16}D{i:13}D{i:4}D{i:19}D{i:21}D{i:22}D{i:23}D{i:24}D{i:25}D{i:20}
D{i:26}D{i:18}D{i:28}D{i:27}D{i:30}D{i:31}D{i:33}D{i:34}D{i:32}D{i:29}D{i:17}D{i:3}
D{i:2}D{i:35}D{i:37}D{i:36}D{i:39}D{i:38}D{i:41}D{i:40}D{i:43}D{i:42}D{i:44}
}
##^##*/
