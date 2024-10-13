QT += quick qml quickcontrols2

SOURCES += \
    $$PWD/qmltypes/inappproductqmltype.cpp \
    $$PWD/qmltypes/inappstoreqmltype.cpp \
    $$PWD/inapp/inappproduct.cpp \
    $$PWD/inapp/inapppurchasebackend.cpp \
    $$PWD/inapp/inappstore.cpp \
    $$PWD/inapp/inapptransaction.cpp

HEADERS += \
    $$PWD/qmltypes/inappproductqmltype.h \
    $$PWD/qmltypes/inappstoreqmltype.h \
    $$PWD/inapp/inappproduct.h \
    $$PWD/inapp/inapppurchasebackend.h \
    $$PWD/inapp/inappstore.h \
    $$PWD/inapp/inapptransaction.h

android {
    QT += core-private

    SOURCES += \
        $$PWD/android/androidinappproduct.cpp \
        $$PWD/android/androidinapppurchasebackend.cpp \
        $$PWD/android/androidinapptransaction.cpp \
        $$PWD/android/androidjni.cpp

    HEADERS += \
        $$PWD/android/androidinappproduct.h \
        $$PWD/android/androidinapppurchasebackend.h \
        $$PWD/android/androidinapptransaction.h

    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android/
    JAVA_CLASS_PATH = $$ANDROID_PACKAGE_SOURCE_DIR/src/org/qtproject/qt/android/purchasing/

    OTHER_FILES += \
        $$PWD/android/AndroidManifest.xml \
        $$PWD/android/build.gradle \
        $$JAVA_CLASS_PATH/Security.java \
        $$JAVA_CLASS_PATH/InAppPurchase.java \
        $$JAVA_CLASS_PATH/Base64.java \
        $$JAVA_CLASS_PATH/Base64DecoderException.java
}

mac {
    #Change the following lines to match your unique App ID
    #to enable in-app purchases on iOS
    #For example if your App ID is org.qtproject.qt.iosteam.qthangman"
    #QMAKE_TARGET_BUNDLE_PREFIX = "org.qtproject.qt.iosteam"
    #TARGET = qthangman

    QMAKE_TARGET_BUNDLE_PREFIX = "org.qtproject.example"
    TARGET = hangman

    LIBS += -framework StoreKit -framework Foundation
    MACPATH += $$PWD/mac/
    HEADERS += \
        $$PWD/ios/iosinapppurchasebackend.h \
        $$PWD/ios/iosinapppurchaseproduct.h \
        $$PWD/ios/iosinapppurchasetransaction.h

    OBJECTIVE_SOURCES += \
        $$PWD/ios/iosinapppurchasebackend.mm \
        $$PWD/ios/iosinapppurchaseproduct.mm \
        $$PWD/ios/iosinapppurchasetransaction.mm
}
