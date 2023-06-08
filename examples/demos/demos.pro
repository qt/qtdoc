TEMPLATE = subdirs

qtHaveModule(quick) {
    SUBDIRS += \
        samegame \
        clocks \
        tweetsearch \
        maroon \
        stocqt

    qtHaveModule(quickcontrols2) {
        SUBDIRS += coffee \
                   colorpaletteclient \
                   calqlatr 


        android|ios: SUBDIRS += hangman
    }

    qtHaveModule(network) {
        qtHaveModule(xml) {
            SUBDIRS += rssnews
        }
    }
}
