TEMPLATE = app

QT += qml quick quickcontrols2
SOURCES += main.cpp

RESOURCES += calqlatr.qrc

OTHER_FILES = Main.qml \
    content/Display.qml \
    content/NumberPad.qml \
    content/CalculatorButton.qml \
    content/calculator.js \
    content/BackspaceButton.qml \
    content/images/backspace.svg \
    content/images/backspace_fill.svg \

target.path = $$[QT_INSTALL_EXAMPLES]/demos/calqlatr
INSTALLS += target
