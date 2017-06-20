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
        caption: qsTr("TachoMeter")
        SectionLayout {

            Label {
                text: qsTr("Actual RPM")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.actualRPM
                    minimumValue: backendValues.minimumRPM.value
                    maximumValue: backendValues.maximumRPM.value
                    decimals: 0
                }

                Controls.Slider {
                    id: rpmSlider
                    Layout.preferredWidth: 100

                    minimumValue: backendValues.minimumRPM.value
                    maximumValue: backendValues.maximumRPM.value
                    updateValueWhileDragging: true
                    stepSize: 1
                    value: backendValues.actualRPM.value
                    onValueChanged: {
                        backendValues.actualRPM.value = rpmSlider.value

                    }

                }

                ExpandingSpacer {
                    width: 30
                }
            }



            Label {
                text: qsTr("Maximum RPM")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.maximumRPM
                    minimumValue: 0
                    maximumValue: 10000
                    decimals: 0
                }

                Controls.Slider {
                    id: maximumRPMSlider
                    Layout.preferredWidth: 100

                    minimumValue: 0
                    maximumValue: 10000
                    updateValueWhileDragging: true
                    stepSize: 1
                    value: backendValues.maximumRPM.value
                    onValueChanged: {
                        backendValues.maximumRPM.value = maximumRPMSlider.value

                    }

                }

                ExpandingSpacer {
                    width: 30
                }
            }

            Label {
                text: qsTr("Minimum RPM")
            }

            SecondColumnLayout {
                SpinBox {
                    backendValue: backendValues.minimumRPM
                    minimumValue: 0
                    maximumValue: 10000
                    decimals: 0
                }

                Controls.Slider {
                    id: minimumRPMSlider
                    Layout.preferredWidth: 100

                    minimumValue: 0
                    maximumValue: 10000
                    updateValueWhileDragging: true
                    stepSize: 1
                    value: backendValues.minimumRPM.value
                    onValueChanged: {
                        backendValues.minimumRPM.value = minimumRPMSlider.value

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
                    stepSize: 1
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
                    stepSize: 1
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
