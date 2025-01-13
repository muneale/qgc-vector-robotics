import QtQuick          2.12
import QtQuick.Controls 2.4
import QtQuick.Layouts  1.11
import QtQuick.Dialogs  1.3

import QGroundControl 1.0
import QGroundControl.Controls 1.0
import QGroundControl.Controllers 1.0
import QGroundControl.Palette 1.0
import QGroundControl.ScreenTools 1.0

import Custom.Buttons 1.0

Rectangle {
    id:     _root
    color:  qgcPal.toolbarBackground

    property int currentToolbar: flyViewToolbar

    readonly property int flyViewToolbar:   0
    readonly property int planViewToolbar:  1
    readonly property int simpleToolbar:    2

    property var    _activeVehicle:     QGroundControl.multiVehicleManager.activeVehicle
    property bool   _communicationLost: _activeVehicle ? _activeVehicle.vehicleLinkManager.communicationLost : false
    property color  _mainStatusBGColor: qgcPal.brandingPurple

    function dropMessageIndicatorTool() {
        if (currentToolbar === flyViewToolbar) {
            indicatorLoader.item.dropMessageIndicatorTool();
        }
    }

    QGCPalette { id: qgcPal }

    // Bottom single pixel divider
    Rectangle {
        anchors.left:   parent.left
        anchors.right:  parent.right
        anchors.bottom: parent.bottom
        height:         1
        color:         "black"
        visible:        qgcPal.globalTheme === QGCPalette.Light
    }

    Rectangle {
        anchors.fill:   mainRow
        visible:        currentToolbar === flyViewToolbar

        // gradient: Gradient {
        //     orientation: Gradient.Horizontal
        //     GradientStop { position: 0;                                     color: _mainStatusBGColor }
        //     GradientStop { position: currentButton.x + currentButton.width; color: _mainStatusBGColor }
        //     GradientStop { position: 1;                                     color: _root.color }
        // }
    }

    RowLayout {
        id:                     mainRow
        anchors.fill:           parent
        anchors.bottomMargin:   1
        spacing:                ScreenTools.defaultFontPixelWidth / 2

        // Logo button
        QGCToolBarButton {
            id:                     currentButton
            Layout.preferredHeight: parent.height
            Layout.preferredWidth:  height * 1.5
            icon.source:            "/res/QGCLogoFull"
            logo:                   true
            onClicked:              mainWindow.showToolSelectDialog()
        }

        // Main content area
        RowLayout {
            Layout.fillWidth:       true
            Layout.fillHeight:      true
            visible:                currentToolbar === flyViewToolbar
            spacing:                ScreenTools.defaultFontPixelWidth / 2

            // Vehicle Status Panel
            Rectangle {
                Layout.fillHeight:  true
                Layout.fillWidth:   true
                color:             "transparent"
                border.width:       1
                border.color:       qgcPal.windowShadeLight
                
                RowLayout {
                    anchors.fill:    parent
                    anchors.margins: 2
                    spacing:         4

                    CustomSensorModeButton {
                        Layout.fillHeight: true
                        Layout.preferredWidth: ScreenTools.defaultFontPixelWidth * 12
                        vehicle: _activeVehicle
                    }
                    
                    // StatusIndicators {
                    //     Layout.fillHeight: true
                    //     Layout.fillWidth:  true
                    // }
                }
            }

            // Time Panel
            Rectangle {
                Layout.fillHeight:  true
                Layout.fillWidth:   true
                color:             "transparent"
                border.width:      1
                border.color:      qgcPal.windowShadeLight

                // TimeDisplay {
                //     anchors.centerIn: parent
                //     vehicle:          _activeVehicle
                // }
            }

            // Target Info Panel
            Rectangle {
                Layout.fillHeight:  true
                Layout.fillWidth:   true
                color:             "transparent"
                border.width:      1
                border.color:      qgcPal.windowShadeLight

                // TargetInfo {
                //     anchors.centerIn: parent
                // }
            }

            // Vehicle Position Panel
            Rectangle {
                Layout.fillHeight:  true
                Layout.fillWidth:   true
                color:             "transparent"
                border.width:      1
                border.color:      qgcPal.windowShadeLight

                // VehiclePosition {
                //     anchors.centerIn: parent
                //     vehicle:          _activeVehicle
                // }
            }
        }

        // Disconnect button
        QGCButton {
            id:                 disconnectButton
            text:              qsTr("Disconnect")
            Layout.preferredHeight: parent.height
            onClicked:         _activeVehicle.closeVehicle()
            visible:           _activeVehicle && _communicationLost && currentToolbar === flyViewToolbar
        }

        // Right side indicators
        QGCFlickable {
            id:                     toolsFlickable
            Layout.fillHeight:      true
            Layout.preferredWidth:  indicatorLoader.width
            contentWidth:           indicatorLoader.width
            flickableDirection:     Flickable.HorizontalFlick

            Loader {
                id:                 indicatorLoader
                anchors.top:        parent.top
                anchors.bottom:     parent.bottom
                source:             currentToolbar === flyViewToolbar ?
                                    "qrc:/toolbar/MainToolBarIndicators.qml" :
                                    (currentToolbar == planViewToolbar ? "qrc:/qml/PlanToolBarIndicators.qml" : "")
            }
        }
    }

    // Progress bars remain unchanged
    Rectangle {
        anchors.bottom: parent.bottom
        height:         _root.height * 0.05
        width:          _activeVehicle ? _activeVehicle.loadProgress * parent.width : 0
        color:          qgcPal.colorGreen
        visible:        !largeProgressBar.visible
    }

    Rectangle {
        id:             largeProgressBar
        anchors.bottom: parent.bottom
        anchors.left:   parent.left
        anchors.right:  parent.right
        height:         parent.height
        color:          qgcPal.window
        visible:        _showLargeProgress

        property bool _initialDownloadComplete: _activeVehicle ? _activeVehicle.initialConnectComplete : true
        property bool _userHide:                false
        property bool _showLargeProgress:       !_initialDownloadComplete && !_userHide && qgcPal.globalTheme === QGCPalette.Light

        Connections {
            target:                 QGroundControl.multiVehicleManager
            function onActiveVehicleChanged(activeVehicle) { largeProgressBar._userHide = false }
        }

        Rectangle {
            anchors.top:    parent.top
            anchors.bottom: parent.bottom
            width:          _activeVehicle ? _activeVehicle.loadProgress * parent.width : 0
            color:          qgcPal.colorGreen
        }

        QGCLabel {
            anchors.centerIn:   parent
            text:               qsTr("Downloading")
            font.pointSize:     ScreenTools.largeFontPointSize
        }

        QGCLabel {
            anchors.margins:    _margin
            anchors.right:      parent.right
            anchors.bottom:     parent.bottom
            text:               qsTr("Click anywhere to hide")
            property real _margin: ScreenTools.defaultFontPixelWidth / 2
        }

        MouseArea {
            anchors.fill:   parent
            onClicked:      largeProgressBar._userHide = true
        }
    }
}