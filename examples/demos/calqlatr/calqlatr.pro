TEMPLATE = app

QT += qml quick quickcontrols2
SOURCES += main.cpp

RESOURCES += calqlatr.qrc

OTHER_FILES = calqlatr.qml \
    content/Display.qml \
    content/NumberPad.qml \
    content/CalculatorButton.qml \
    content/calculator.js \
    content/images/paper-edge-left.png \
    content/images/paper-edge-right.png \
    content/images/paper-grip.png

target.path = $$[QT_INSTALL_EXAMPLES]/demos/calqlatr
INSTALLS += target
