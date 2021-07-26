TEMPLATE = subdirs

qtHaveModule(quick) {
    SUBDIRS += \
        samegame \
        calqlatr \
        clocks \
        tweetsearch \
        maroon \
        photosurface \
        stocqt

    qtHaveModule(quickcontrols2) {
        SUBDIRS += coffee

        android|ios: SUBDIRS += hangman
    }

    qtHaveModule(network) {
        qtHaveModule(xml) {
            SUBDIRS += rssnews
        }
        qtHaveModule(quickcontrols2) {
            SUBDIRS += photoviewer
        }
    }
}
