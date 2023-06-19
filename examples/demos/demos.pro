TEMPLATE = subdirs

qtHaveModule(quick) {
    SUBDIRS += \
        samegame \
        calqlatr \
        clocks \
        tweetsearch \
        maroon \
        stocqt

    qtHaveModule(quickcontrols2) {
        SUBDIRS += coffee \
                   colorpaletteclient

        android|ios: SUBDIRS += hangman
        qtHaveModule(quick3d):qtHaveModule(quick3dphysics) {
            SUBDIRS += dice
        }
    }

    qtHaveModule(network) {
        qtHaveModule(xml) {
            SUBDIRS += rssnews
        }
    }
}
