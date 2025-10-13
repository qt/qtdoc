// Copyright (C) 2025 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick3D

Node {
    id: root

    readonly property alias bodyRigged: bodyRigged
    property alias accessoryModel: matLib.accessoryModel

    property alias toyNodeModel: toyNodeModel
    property alias accessoryHolder_Hand_Right: accessoryHolder_Hand_Right
    property alias universalArmature: universalArmature
    property alias universalRigged: universalRigged
    property alias universalRiggedLPlatform: universalRiggedLPlatform
    property alias universalRiggedRPlatform: universalRiggedRPlatform
    property alias universalRiggedTail: universalRiggedTail
    property alias universalRiggedEar_R: universalRiggedEar_R
    property alias universalRiggedEar_L: universalRiggedEar_L
    property alias universalRiggedHead: universalRiggedHead
    property alias universalRiggedNeck: universalRiggedNeck
    property alias universalRiggedRibcage: universalRiggedRibcage
    property alias universalRiggedLPalm: universalRiggedLPalm
    property alias universalRiggedRPalm: universalRiggedRPalm
    property alias universalRiggedLUpperarm: universalRiggedLUpperarm
    property alias universalRiggedRUpperarm: universalRiggedRUpperarm
    property alias universalRiggedLCollarbone: universalRiggedLCollarbone
    property alias universalRiggedRCollarbone: universalRiggedRCollarbone
    property alias universalRiggedLForearm: universalRiggedLForearm
    property alias universalRiggedRForearm: universalRiggedRForearm
    property alias universalRiggedLFoot: universalRiggedLFoot
    property alias universalRiggedRFoot: universalRiggedRFoot
    property alias universalRiggedSpine1: universalRiggedSpine1
    property alias universalRiggedSpine2: universalRiggedSpine2
    property alias universalRiggedSpine3: universalRiggedSpine3
    property alias universalRiggedPelvis: universalRiggedPelvis
    property alias universalRiggedLCalf: universalRiggedLCalf
    property alias universalRiggedRCalf: universalRiggedRCalf
    property alias universalRiggedRThigh: universalRiggedRThigh
    property alias universalRiggedLThigh: universalRiggedLThigh
    property alias neutralBone: neutral_bone

    property alias accessoryHolderHandLeft: accessoryHolder_Hand_Left
    property alias accessoryHolderHandRight: accessoryHolder_Hand_Right
    property alias accessoryHolderEyes: _EyeHolder
    property alias accessoryHolderEyewear: _EyewearHolder
    property alias accessoryHolderHeadwear: _HeadwearHolder
    property alias accessoryHolderHead: accessoryHolder_Head
    property alias accessoryHolderBody: accessoryHolder_Body

    property alias accessoryAnnoyedEyebrows: eyebrows_005
    property alias accessoryAnnoyedEyes: annoyedEyes
    property alias accessoryAnnoyedMouth: mouth
    property alias accessoryBraceletLeft: metalBracelet_Left
    property alias accessoryBraceletRight: metalBracelet_Right
    property alias accessoryConfusedEyes: confusedEyes
    property alias accessoryConfusedMouth: crazyMouth
    property alias accessoryCuteEyebrows: eyebrows_006
    property alias accessoryCuteEyes: cuteEyes
    property alias accessoryCuteMouth: mouth1
    property alias accessoryPowerpuffEyebrows: eyebrows_007
    property alias accessoryPowerpuffEyes: powerpuffEyes
    property alias accessoryPowerpuffMouth: happyMouth
    property alias accessorySmallEyebrows: eyebrows_008
    property alias accessorySmallEyes: smallEyes
    property alias accessorySmallMouth: smallMouth1
    property alias accessorySurprisedEyebrows: eyebrows
    property alias accessorySurprisedEyes: surprisedEyes
    property alias accessorySurprisedMouth: happyMouth1

    property alias modelMetalBraceletLeft: metalBracelet_Left
    property alias modelMetalBraceletRight: metalBracelet_Right
    property alias modelAnnoyedEyes: annoyedEyes
    property alias modelAnnoyedEyebrows: eyebrows_005
    property alias modelAnnoyedMouth: mouth
    property alias modelConfusedEyes: confusedEyes
    property alias modelCuteEyes: cuteEyes
    property alias modelCuteEyebrows: eyebrows_006
    property alias modelCuteMouth: mouth1
    property alias modelPowerpuffEyes: powerpuffEyes
    property alias modelPowerpuffEyebrows: eyebrows_007
    property alias modelPowerpuffMouth: happyMouth
    property alias modelSmallEyes: smallEyes
    property alias modelSmallEyebrows: eyebrows_008
    property alias modelSmallMouth: smallMouth1
    property alias modelSurprisedEyes: surprisedEyes
    property alias modelSurprisedEyebrows: eyebrows
    property alias modelSurprisedMouth: happyMouth1
    property alias modelWideEyes: wideEyes
    property alias modelWideEyes_1: plane_002
    property alias modelWideEyes_2: plane_003
    property alias modelWideEyes_3: plane_004
    property alias modelWideMouth: smallMouth
    property alias modelEyePatch: eyePatch
    property alias modelIncognito: incognito
    property alias modelMonocle: monocle
    property alias modelNVGoggles: nvgoggles
    property alias modelRoundGlasses: roundGlasses
    property alias modelSunglasses: sunglasses
    property alias modelBandana: bandana
    property alias modelBeanie: beanie
    property alias modelCap: cap
    property alias modelConeHat: coneHat
    property alias modelHeadphones: headphones
    property alias modelWizardHat: wizardhat
    property alias modelWhiskers: whiskers
    property alias modelAngelWings: angelWings
    property alias modelBackpack: backpack
    property alias modelBowTie: bowTie
    property alias modelButterflyWings: butterflyWings
    property alias modelNecktie: necktie

    scale: Qt.vector3d(115, 115, 110)

    Node {
        id: bodyRigged

        AccessoryMaterialLibrary {
            id: matLib
        }

        Node {
            id: universalArmature
            Model {
                id: toyNodeModel
            }
            Node {
                id: universalRigged
            }
            Node {
                id: universalRiggedPelvis
                Node {
                    id: universalRiggedLThigh
                    Node {
                        id: universalRiggedLCalf
                        Node {
                            id: universalRiggedLFoot
                        }
                    }
                }
                Node {
                    id: universalRiggedRThigh
                    Node {
                        id: universalRiggedRCalf
                        Node {
                            id: universalRiggedRFoot
                        }
                    }
                }
                Node {
                    id: universalRiggedSpine1
                    Node {
                        id: universalRiggedSpine2
                        Node {
                            id: universalRiggedSpine3
                            Node {
                                id: universalRiggedRibcage
                                Node {
                                    id: universalRiggedLCollarbone
                                    Node {
                                        id: universalRiggedLUpperarm
                                        Node {
                                            id: universalRiggedLForearm
                                            Node {
                                                id: universalRiggedLPalm
                                                Node {
                                                    id: accessoryHolder_Hand_Left
                                                    Model {
                                                        id: metalBracelet_Left
                                                        visible: AccessoryState.metalBracelet_LeftVisible
                                                        source: "meshes/cylinder_009_mesh.mesh"
                                                        castsReflections: false
                                                        receivesShadows: false
                                                        castsShadows: false
                                                        materials: matLib.items_generic
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                Node {
                                    id: universalRiggedRCollarbone
                                    Node {
                                        id: universalRiggedRUpperarm
                                        Node {
                                            id: universalRiggedRForearm
                                            Node {
                                                id: universalRiggedRPalm
                                                Node {
                                                    id: accessoryHolder_Hand_Right
                                                    Model {
                                                        id: metalBracelet_Right
                                                        visible: AccessoryState.metalBracelet_RightVisible
                                                        castsReflections: false
                                                        receivesShadows: false
                                                        castsShadows: false
                                                        source: "meshes/cylinder_009_mesh.mesh"
                                                        materials: matLib.items_generic
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                Node {
                                    id: universalRiggedNeck
                                    Node {
                                        id: universalRiggedHead
                                        Node {
                                            id: universalRiggedEar_L
                                        }
                                        Node {
                                            id: universalRiggedEar_R
                                        }
                                        Node {
                                            id: _EyeHolder
                                            Model {
                                                id: annoyedEyes
                                                visible: AccessoryState.annoyedEyesVisible
                                                castsReflections: false
                                                receivesShadows: false
                                                castsShadows: false
                                                source: "meshes/mesh_005_mesh.mesh"
                                                materials: matLib.annoyedEyes
                                                Model {
                                                    id: eyebrows_005
                                                    castsReflections: false
                                                    receivesShadows: false
                                                    castsShadows: false
                                                    source: "meshes/mesh_007_mesh.mesh"
                                                    materials: matLib.eyeBrows_Black
                                                }
                                                Model {
                                                    id: mouth
                                                    castsReflections: false
                                                    receivesShadows: false
                                                    castsShadows: false
                                                    source: "meshes/mesh_013_mesh.mesh"
                                                    materials: matLib.mouth
                                                }
                                            }
                                            Model {
                                                id: confusedEyes
                                                visible: AccessoryState.confusedEyesVisible
                                                castsReflections: false
                                                receivesShadows: false
                                                castsShadows: false
                                                source: "meshes/plane_014_mesh.mesh"
                                                materials: matLib.eyeBrows_Black
                                                Model {
                                                    id: crazyMouth
                                                    castsReflections: false
                                                    receivesShadows: false
                                                    castsShadows: false
                                                    source: "meshes/empty_mesh.mesh"
                                                    materials: matLib.crazyMouthMat
                                                }
                                            }
                                            Model {
                                                id: cuteEyes
                                                visible: AccessoryState.cuteEyesVisible
                                                castsReflections: false
                                                receivesShadows: false
                                                castsShadows: false
                                                source: "meshes/mesh_003_mesh.mesh"
                                                materials: matLib.quteEyes
                                                Model {
                                                    id: eyebrows_006
                                                    castsReflections: false
                                                    receivesShadows: false
                                                    castsShadows: false
                                                    source: "meshes/mesh_004_mesh.mesh"
                                                    materials: matLib.eyeBrows_Black_004
                                                }

                                                Model {
                                                    id: mouth1
                                                    source: "meshes/mesh_013_mesh.mesh"
                                                    materials: matLib.mouth
                                                }
                                            }
                                            Model {
                                                id: powerpuffEyes
                                                visible: AccessoryState.powerpuffEyesVisible
                                                castsReflections: false
                                                receivesShadows: false
                                                castsShadows: false
                                                source: "meshes/mesh_011_mesh.mesh"
                                                materials: matLib.powerpuffEyes_001
                                                Model {
                                                    id: eyebrows_007
                                                    castsShadows: false
                                                    receivesShadows: false
                                                    castsReflections: false
                                                    source: "meshes/mesh_014_mesh.mesh"
                                                    materials: matLib.eyeBrows_Black_001
                                                }
                                                Model {
                                                    id: happyMouth
                                                    castsShadows: false
                                                    receivesShadows: false
                                                    castsReflections: false
                                                    source: "meshes/empty_003_mesh.mesh"
                                                    materials: matLib.happyMouthMat
                                                }
                                            }
                                            Model {
                                                id: smallEyes
                                                visible: AccessoryState.smallEyesVisible
                                                castsReflections: false
                                                receivesShadows: false
                                                castsShadows: false
                                                source: "meshes/mesh_124_mesh.mesh"
                                                materials: matLib.defaultEyes
                                                Model {
                                                    id: eyebrows_008
                                                    castsReflections: false
                                                    receivesShadows: false
                                                    castsShadows: false
                                                    source: "meshes/mesh_016_mesh.mesh"
                                                    materials: matLib.eyeBrows_Black_005
                                                }
                                                Model {
                                                    id: smallMouth1
                                                    receivesShadows: false
                                                    castsShadows: false
                                                    castsReflections: false
                                                    source: "meshes/empty_001_mesh.mesh"
                                                    materials: matLib.smallMouthMat
                                                }
                                            }
                                            Model {
                                                id: surprisedEyes
                                                visible: AccessoryState.surprisedEyesVisible
                                                castsReflections: false
                                                receivesShadows: false
                                                castsShadows: false
                                                source: "meshes/mesh_008_mesh.mesh"
                                                materials: matLib.defaultEyes
                                                Model {
                                                    id: eyebrows
                                                    castsShadows: false
                                                    receivesShadows: false
                                                    castsReflections: false
                                                    source: "meshes/mesh_009_mesh.mesh"
                                                    materials: matLib.eyeBrows_Black
                                                }
                                                Model {
                                                    id: happyMouth1
                                                    castsReflections: false
                                                    receivesShadows: false
                                                    castsShadows: false
                                                    source: "meshes/empty_003_mesh.mesh"
                                                    materials: matLib.happyMouthMat
                                                }
                                            }
                                            Model {
                                                id: wideEyes
                                                castsReflections: false
                                                receivesShadows: false
                                                castsShadows: false
                                                visible: AccessoryState.wideEyesVisible
                                                source: "meshes/mesh_010_mesh.mesh"
                                                materials: matLib.eyeBrows_Black

                                                Model {
                                                    id: plane_002
                                                    materials: matLib.eyeBrows_Black_002
                                                    source: "meshes/plane_015_mesh.mesh"
                                                }
                                                Model {
                                                    id: plane_003
                                                    materials: matLib.eyeBrows_Black_003
                                                    source: "meshes/plane_016_mesh.mesh"
                                                }
                                                Model {
                                                    id: plane_004
                                                    materials: matLib.eyeBrows_Black_004
                                                    source: "meshes/plane_017_mesh.mesh"
                                                    castsReflections: false
                                                    receivesShadows: false
                                                    castsShadows: false
                                                }
                                                Model {
                                                    id: smallMouth
                                                    materials: matLib.smallMouthMat
                                                    source: "meshes/empty_001_mesh.mesh"
                                                    castsReflections: false
                                                    receivesShadows: false
                                                    castsShadows: false
                                                }
                                            }
                                        }
                                        Node {
                                            id: _EyewearHolder
                                            Model {
                                                id: eyePatch
                                                visible: AccessoryState.eyePatchVisible
                                                castsReflections: false
                                                receivesShadows: false
                                                castsShadows: false
                                                source: "meshes/mesh_002_mesh.mesh"
                                                materials: matLib.eyewear_generic
                                            }
                                            Model {
                                                id: incognito
                                                visible: AccessoryState.incognitoVisible
                                                castsReflections: false
                                                receivesShadows: false
                                                castsShadows: false
                                                source: "meshes/mesh_006_mesh.mesh"
                                                materials: matLib.nose
                                            }
                                            Model {
                                                id: monocle
                                                visible: AccessoryState.monacleVisible
                                                castsReflections: false
                                                receivesShadows: false
                                                castsShadows: false
                                                source: "meshes/mesh_015_mesh.mesh"
                                                materials: matLib.eyewear_generic
                                            }
                                            Model {
                                                id: nvgoggles
                                                visible: AccessoryState.nvGogglesVisible
                                                castsReflections: false
                                                receivesShadows: false
                                                castsShadows: false
                                                source: "meshes/nvgoggles_mesh.mesh"
                                                materials: [
                                                    matLib.nvgoggles_lens,
                                                    matLib.nvgoggles_body,
                                                    matLib.darkTextile,
                                                    matLib.nvgoggleDetail
                                                ]
                                            }
                                            Model {
                                                id: roundGlasses
                                                visible: AccessoryState.roundGlassesVisible
                                                castsReflections: false
                                                receivesShadows: false
                                                castsShadows: false
                                                source: "meshes/torus_002_mesh.mesh"
                                                materials: matLib.eyewear_generic
                                            }
                                            Model {
                                                id: sunglasses
                                                visible: AccessoryState.sunglassesVisible
                                                castsReflections: false
                                                receivesShadows: false
                                                castsShadows: false
                                                source: "meshes/plane_001_mesh.mesh"
                                                materials: matLib.eyewear_generic
                                            }
                                        }
                                        Node {
                                            id: _HeadwearHolder
                                            Model {
                                                id: bandana
                                                visible: AccessoryState.bandanaVisible
                                                receivesShadows: false
                                                castsReflections: false
                                                castsShadows: false
                                                source: "meshes/cylinder_004_mesh.mesh"
                                                materials: matLib.bandana
                                            }
                                            Model {
                                                id: beanie
                                                visible: AccessoryState.beanieVisible
                                                receivesShadows: false
                                                castsReflections: false
                                                castsShadows: false
                                                source: "meshes/cylinder_002_mesh.mesh"
                                                materials: matLib.beanie
                                            }
                                            Model {
                                                id: cap
                                                visible: AccessoryState.capVisible
                                                receivesShadows: false
                                                castsReflections: false
                                                castsShadows: false
                                                source: "meshes/cap_mesh.mesh"
                                                materials: [matLib.cap, matLib.capFront]
                                            }
                                            Model {
                                                id: coneHat
                                                visible: AccessoryState.partyHatVisible
                                                receivesShadows: false
                                                castsReflections: false
                                                castsShadows: false
                                                source: "meshes/cone_mesh.mesh"
                                                materials: matLib.bdayHat
                                            }
                                            Model {
                                                id: headphones
                                                visible: AccessoryState.headphonesVisible
                                                receivesShadows: false
                                                castsReflections: false
                                                castsShadows: false
                                                source: "meshes/cylinder_001_mesh.mesh"
                                                materials: matLib.headphones
                                            }
                                            Model {
                                                id: wizardhat
                                                visible: AccessoryState.wizardHatVisible
                                                receivesShadows: false
                                                castsReflections: false
                                                castsShadows: false
                                                source: "meshes/cylinder_005_mesh.mesh"
                                                materials: matLib.wizardHat
                                            }
                                        }
                                        Node {
                                            id: accessoryHolder_Head
                                            Model {
                                                id: whiskers
                                                visible: AccessoryState.whiskersVisible
                                                castsReflections: false
                                                receivesShadows: false
                                                castsShadows: false
                                                source: "meshes/mesh_019_mesh.mesh"
                                                materials: matLib.whiskers
                                            }
                                        }
                                    }
                                }
                            }
                            Node {
                                id: accessoryHolder_Body
                                Model {
                                    id: angelWings
                                    visible: AccessoryState.angelWingsVisible
                                    castsReflections: false
                                    receivesShadows: false
                                    castsShadows: false
                                    source: "meshes/plane_018_mesh.mesh"
                                    materials: matLib.angelWings
                                }
                                Model {
                                    id: backpack
                                    visible: AccessoryState.backpackVisible
                                    castsReflections: false
                                    receivesShadows: false
                                    castsShadows: false
                                    source: "meshes/cube_001_mesh.mesh"
                                    materials: matLib.backpack
                                }
                                Model {
                                    id: bowTie
                                    visible: AccessoryState.bowtieVisible
                                    castsReflections: false
                                    receivesShadows: false
                                    castsShadows: false
                                    source: "meshes/mesh_mesh.mesh"
                                    materials: matLib.bowtie
                                }
                                Model {
                                    id: butterflyWings
                                    visible: AccessoryState.butterflyWingsVisible
                                    castsReflections: false
                                    receivesShadows: false
                                    castsShadows: false
                                    source: "meshes/mesh_012_mesh.mesh"
                                    materials: matLib.butterflyWings
                                }
                                Model {
                                    id: necktie
                                    visible: AccessoryState.necktieVisible
                                    castsReflections: false
                                    receivesShadows: false
                                    castsShadows: false
                                    source: "meshes/torus_001_mesh.mesh"
                                    materials: matLib.necktie
                                }
                            }
                        }
                    }
                }
                Node {
                    id: universalRiggedTail
                }
            }
            Node {
                id: universalRiggedLPlatform
            }
            Node {
                id: universalRiggedRPlatform
            }
            Node {
                id: neutral_bone
            }
        }
    }
}
