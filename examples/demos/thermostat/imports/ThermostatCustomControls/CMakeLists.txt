# Copyright (C) 2023 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

qt_add_library(ThermostatCustomControls STATIC)
qt_add_qml_module(ThermostatCustomControls
    URI "ThermostatCustomControls"
    VERSION 1.0
    QML_FILES
        CustomComboBox.qml
        CustomDial.qml
        CustomRadioButton.qml
        CustomRoundButton.qml
        CustomSlider.qml
        CustomSwitch.qml
        CustomTextField.qml
        StatisticsChart.qml
        TemperatureLabel.qml
        ThermostatControl.qml
        TimeSelector.qml
    RESOURCES
        images/keyboard.svg
        images/thermometer.svg
        images/tooltip.svg
)
