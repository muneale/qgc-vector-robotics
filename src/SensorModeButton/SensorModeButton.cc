// SensorModeButton.cpp
#include "SensorModeButton.h"
#include <QDebug>

SensorModeButton::SensorModeButton(QQuickItem *parent) 
    : QQuickItem(parent)
    , _vehicle(nullptr)
{
    // QQuickItem specific setup
    setFlag(ItemHasContents, true);
}

void SensorModeButton::setVehicle(Vehicle* vehicle)
{
    if (_vehicle != vehicle) {
        _vehicle = vehicle;
        emit vehicleChanged();
    }
}

void SensorModeButton::sendCommand()
{
    if (!_vehicle) {
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

    MAV_CMD command = MAV_CMD_DO_DIGICAM_CONTROL; // Replace with actual command ID
    
    _vehicle->sendMavCommand(
        MAV_COMP_ID_ALL,           // Component ID
        command,                   // Command ID
        false,                     // showError
        param1, param2, param3, param4,
        param5, param6, param7);
}
