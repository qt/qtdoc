TEMPLATE = subdirs

qtHaveModule(quick) {
    SUBDIRS += \
        samegame \
        clocks \
        maroon

    qtHaveModule(quick3d):qtHaveModule(quick3dphysics):qtHaveModule(quick3dxr):qtHaveModule(multimedia) {
        SUBDIRS += xr_physicsbase_teleportation
    }

    qtHaveModule(quickcontrols2) {
        SUBDIRS += coffee \
                   colorpaletteclient \
                   calqlatr 


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
