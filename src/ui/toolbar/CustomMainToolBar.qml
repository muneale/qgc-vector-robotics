import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QGroundControl.ScreenTools 1.0
import QGroundControl.Controllers 1.0
import QGroundControl.Controls 1.0
import QGroundControl.Palette 1.0
import QGroundControl 1.0
import Custom.Buttons 1.0

Rectangle {
    id: mainToolBar
    height: ScreenTools.toolbarHeight
    color: qgcPal.windowShade

    QGCPalette { id: qgcPal; colorGroupEnabled: true }

    property var activeVehicle: QGroundControl.multiVehicleManager.activeVehicle
    property var missionController: QGroundControl.missionController

    RowLayout {
        anchors.fill: parent
        spacing: 0

        Rectangle {
            Layout.preferredWidth: parent.width * 0.2
            height: parent.height
            color: "transparent"
            border.width: 1
            border.color: qgcPal.windowShadeLight
            
            RowLayout {
                anchors.fill: parent
                anchors.margins: 2
                spacing: 4

                CustomSensorModeButton {
                    Layout.fillHeight: true
                    Layout.preferredWidth: ScreenTools.defaultFontPixelWidth * 12
                }
                
                ColumnLayout {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    spacing: 2
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 4
                        QGCColoredImage {
                            source:             "/qmlimages/Battery.svg"
                            height:             ScreenTools.defaultFontPixelHeight
                            width:              height
                            sourceSize.height:  height
                            fillMode:           Image.PreserveAspectFit
                            color:              activeVehicle && activeVehicle.battery1.percentRemaining > 20 ? "lime" : "red"
                        }
                        Text {
                            Layout.fillWidth: true
                            horizontalAlignment: Text.AlignLeft
                            text: activeVehicle ? (activeVehicle.battery1.percentRemaining.toFixed(0) || "0") + "%" : "---%"
                            color: activeVehicle && activeVehicle.battery1.percentRemaining > 20 ? "lime" : "red"
                            font.pixelSize: ScreenTools.defaultFontPixelSize
                            font.bold: true
                            elide: Text.ElideRight
                        }
                    }
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 4
                        QGCColoredImage {
                            source:             "/qmlimages/Battery.svg"
                            height:             ScreenTools.defaultFontPixelHeight
                            width:              height
                            sourceSize.height:  height
                            fillMode:           Image.PreserveAspectFit
                            color:              activeVehicle && activeVehicle.battery2.percentRemaining > 20 ? "lime" : "red"
                        }
                        Text {
                            Layout.fillWidth: true
                            horizontalAlignment: Text.AlignLeft
                            text: activeVehicle ? (activeVehicle.battery2.percentRemaining.toFixed(0) || "0") + "%" : "---%"
                            color: activeVehicle && activeVehicle.battery2.percentRemaining > 20 ? "lime" : "red"
                            font.pixelSize: ScreenTools.defaultFontPixelSize
                            font.bold: true
                            elide: Text.ElideRight
                        }
                    }
                }
                
                ColumnLayout {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    spacing: 2
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 4
                        QGCColoredImage {
                            source:             "/qmlimages/Signal.svg"
                            height:             ScreenTools.defaultFontPixelHeight
                            width:              height
                            sourceSize.height:  height
                            fillMode:           Image.PreserveAspectFit
                            color:              activeVehicle && activeVehicle.rcRSSI.value > 40 ? "lime" : "red"
                        }
                        Text {
                            Layout.fillWidth: true
                            horizontalAlignment: Text.AlignLeft
                            text: activeVehicle ? (activeVehicle.rcRSSI.valueString || "0") + "%" : "---%"
                            color: activeVehicle && activeVehicle.rcRSSI.value > 40 ? "lime" : "red"
                            font.pixelSize: ScreenTools.defaultFontPixelSize
                            font.bold: true
                            elide: Text.ElideRight
                        }
                    }
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 4
                        QGCColoredImage {
                            source:             "/qmlimages/GPS.svg"
                            height:             ScreenTools.defaultFontPixelHeight
                            width:              height
                            sourceSize.height:  height
                            fillMode:           Image.PreserveAspectFit
                            color:              activeVehicle && activeVehicle.gps.count.value >= 6 ? "lime" : "red"
                        }
                        Text {
                            Layout.fillWidth: true
                            horizontalAlignment: Text.AlignLeft
                            text: activeVehicle ? (activeVehicle.gps.count.value || "0") + "+" : "---+"
                            color: activeVehicle && activeVehicle.gps.count.value >= 6 ? "lime" : "red"
                            font.pixelSize: ScreenTools.defaultFontPixelSize
                            font.bold: true
                            elide: Text.ElideRight
                        }
                    }
                }
            }
        }

        Rectangle {
            Layout.preferredWidth: parent.width * 0.2
            height: parent.height
            color: "transparent"
            border.width: 1
            border.color: qgcPal.windowShadeLight

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 2

                Text {
                    text: "Mission Time: " + (activeVehicle ? activeVehicle.flightTime : "00:00:00")
                    color: qgcPal.text
                    font.pixelSize: ScreenTools.defaultFontPixelSize
                    font.bold: true
                }

                Text {
                    text: "Flight Time: " + (activeVehicle ? activeVehicle.flightTime : "00:00:00")
                    color: qgcPal.text
                    font.pixelSize: ScreenTools.defaultFontPixelSize
                    font.bold: true
                }
            }
        }

        Rectangle {
            Layout.preferredWidth: parent.width * 0.2
            height: parent.height
            color: "transparent"
            border.width: 1
            border.color: qgcPal.windowShadeLight

            RowLayout {
                spacing: 10
                anchors.centerIn: parent

                Text {
                    // text: "AZ " + targetHeading + "° DST " + targetDistance + "m"
                    text: "AZ ---° DST --- m"
                    color: "gold"
                    font.pixelSize: ScreenTools.defaultFontPixelSize
                    font.bold: true
                }

            }
        }

        Rectangle {
            Layout.preferredWidth: parent.width * 0.4
            height: parent.height
            color: "transparent"
            border.width: 1
            border.color: qgcPal.windowShadeLight

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 2

                Text {
                    text: activeVehicle ? 
                        "▲ " + (activeVehicle.coordinate.latitude.toFixed(5) || "0.00000") + 
                        ", " + (activeVehicle.coordinate.longitude.toFixed(6) || "0.000000") :
                        "▲ ---.-----, ---.------"
                    color: qgcPal.text
                    font.pixelSize: ScreenTools.defaultFontPixelSize
                    font.bold: true
                }

                RowLayout {
                    spacing: 10
                    
                    Text {
                        text: activeVehicle ? 
                              "AZ " + (activeVehicle.heading.value.toFixed(0) || "0") + "°" : "AZ ---°"
                        color: qgcPal.text
                        font.pixelSize: ScreenTools.defaultFontPixelSize
                        font.bold: true
                    }

                    Text {
                        text: activeVehicle ? 
                              "ALT " + (activeVehicle.altitudeRelative.value.toFixed(1) || "0") + "m" : "ALT ---m"
                        color: qgcPal.text
                        font.pixelSize: ScreenTools.defaultFontPixelSize
                        font.bold: true
                    }

                    Text {
                        text: activeVehicle ? 
                              "GS " + (activeVehicle.groundSpeed.value.toFixed(1) || "0") + "m/s" :
                              "GS ---m/s"
                        color: qgcPal.text
                        font.pixelSize: ScreenTools.defaultFontPixelSize
                        font.bold: true
                    }
                }
            }
        }
    }
}
