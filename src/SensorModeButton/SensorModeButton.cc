#include <QDebug>
#include "SensorModeButton.h"

SensorModeButton::SensorModeButton(QQuickItem *parent) 
    : QQuickItem(parent)
{
    setFlag(ItemHasContents, true);
}

void SensorModeButton::setVehicle(Vehicle* vehicle)
{
    if (_vehicle.data() != vehicle) {
        _vehicle = vehicle;
        emit vehicleChanged();
    }
}

void SensorModeButton::sendCommand()
{
    qDebug() << "Sending command";

    if (!_vehicle || !_vehicle.data()) {  // Check both for null and validity
        qDebug() << "No vehicle available";
        return;
    }

    // MAVLink COMMAND_LONG message parameters
    float param1 = 3;
    float param2 = 0;
    float param3 = 0;
    float param4 = 0;
    float param5 = 0;
    float param6 = 0;
    float param7 = 0;

    if (_mode == 0) {
        param2 = 1;
    }

    _mode = param2;

    qDebug() << "Sending command with param2: " << param2;

    MAV_CMD command = MAV_CMD_DO_DIGICAM_CONTROL;
    
    _vehicle->sendMavCommand(
        MAV_COMP_ID_ALL,
        command,
        true,
        param1, param2, param3, param4,
        param5, param6, param7);
    
    qDebug() << "Command sent";
}
