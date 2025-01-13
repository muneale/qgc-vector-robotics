// SensorModeButton.h
#pragma once

#include <QQuickItem>
#include "Vehicle/Vehicle.h"

class SensorModeButton : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(Vehicle* vehicle READ vehicle WRITE setVehicle NOTIFY vehicleChanged)

public:
    explicit SensorModeButton(QQuickItem *parent = nullptr);
    
    Vehicle* vehicle() const { return _vehicle; }
    void setVehicle(Vehicle* vehicle);

signals:
    void vehicleChanged();

public slots:
    Q_INVOKABLE void sendCommand();

private:
    Vehicle* _vehicle;
    int _mode = 0;
};
