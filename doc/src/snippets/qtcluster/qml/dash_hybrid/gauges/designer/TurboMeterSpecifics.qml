/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of Qt Creator.
**
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 as published by the Free Software
** Foundation with exceptions as appearing in the file LICENSE.GPL3-EXCEPT
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
****************************************************************************/

import QtQuick 2.1
import HelperWidgets 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.0 as Controls

Column {
    anchors.left: parent.left
    anchors.right: parent.right

    Section {
        anchors.left: parent.left
        anchors.right: parent.right
        caption: qsTr("TurboMeter")
        SectionLayout {

            Label {
                text: qsTr("Turbo Value")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.turboValue
                    minimumValue: 0
                    maximumValue: backendValues.maximumValue.value
                    decimals: 0
                }

                Controls.Slider {
                    id: turboSlider
                    Layout.preferredWidth: 100

                    minimumValue: 0
                    maximumValue: backendValues.maximumValue.value
                    updateValueWhileDragging: true
                    stepSize: 0.1
                    value: backendValues.turboValue.value
                    onValueChanged: {
                        backendValues.turboValue.value = turboSlider.value

                    }

                }

                ExpandingSpacer {
                    width: 30
                }
            }



            Label {
                text: qsTr("Maximum Turbo")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.maximumValue
                    minimumValue: 0
                    maximumValue: 1000
                    decimals: 0
                }

                Controls.Slider {
                    id: maximumFuelSlider
                    Layout.preferredWidth: 100

                    minimumValue: 0
                    maximumValue: 1000
                    updateValueWhileDragging: true
                    stepSize: 10
                    value: backendValues.maximumValue.value
                    onValueChanged: {
                        backendValues.maximumValue.value = maximumFuelSlider.value

                    }

                }

                ExpandingSpacer {
                    width: 30
                }
            }

            Label {
                text: qsTr("Maximum Value Angle")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.maxValueAngle
                    minimumValue: 0
                    maximumValue: 360
                    decimals: 0
                }

                Controls.Slider {
                    id: maxValueAngleSlider
                    Layout.preferredWidth: 100

                    minimumValue: 0
                    maximumValue: 360
                    updateValueWhileDragging: true
                    stepSize: 10
                    value: backendValues.maxValueAngle.value
                    onValueChanged: {
                        backendValues.maxValueAngle.value = maxValueAngleSlider.value
                    }

                }

                ExpandingSpacer {
                    width: 30
                }
            }

            Label {
                text: qsTr("Minimum Value Angle")
            }


            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.minValueAngle
                    minimumValue: 0
                    maximumValue: 360
                    decimals: 0
                }

                Controls.Slider {
                    id: minValueAngleSlider
                    Layout.preferredWidth: 100

                    minimumValue: 0
                    maximumValue: 360
                    updateValueWhileDragging: true
                    stepSize: 10
                    value: backendValues.minValueAngle.value
                    onValueChanged: {
                        backendValues.minValueAngle.value = minValueAngleSlider.value
                    }

                }

                ExpandingSpacer {
                    width: 30
                }
            }

        }
    }
}
