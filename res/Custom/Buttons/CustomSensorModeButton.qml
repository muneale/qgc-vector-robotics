import QtQuick          2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts  1.15
import QGroundControl.Palette 1.0
import QGroundControl.ScreenTools 1.0
import Custom 1.0

Item {
    id: root
    
    property var vehicle: QGroundControl.multiVehicleManager.activeVehicle
    
    // Set explicit size based on toolbar height
    implicitWidth: button.implicitWidth
    implicitHeight: button.implicitHeight

    Button {
        id: button
        anchors.fill: parent
        
        implicitWidth: ScreenTools.defaultFontPixelWidth * 12
        implicitHeight: parent.height - 4  // Leave small margin

        // Use QGC palette for consistent styling
        QGCPalette { id: qgcPal; colorGroupEnabled: enabled }
        
        background: Rectangle {
            color: button.pressed ? qgcPal.buttonHighlight : qgcPal.button
            border.color: qgcPal.buttonText
            border.width: 1
            radius: 3
        }
        
        contentItem: Text {
            text: qsTr("Sensor Mode")
            color: qgcPal.buttonText
            font.pixelSize: ScreenTools.defaultFontPixelSize
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        
        onClicked: {
            if (sensorButton.vehicle) {
                sensorButton.sendCommand()
            }
        }
    }

    SensorModeButton {
        id: sensorButton
        vehicle: root.vehicle
    }
}