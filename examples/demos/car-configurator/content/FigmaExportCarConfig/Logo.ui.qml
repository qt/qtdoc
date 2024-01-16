// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick

Item {
    id: root

    width: 144
    height: 45
    state: "state_color_Dark"
    clip: true

    SvgPathItem {
        id: background

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        antialiasing: true
        fillColor: "#000000"
        path: "M 0 0 L 144 0 L 144 45 L 0 45 L 0 0 Z"
        strokeWidth: 1
    }

    SvgPathItem {
        id: logo

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 12
        antialiasing: true
        fillColor: "#ffffff"
        anchors.bottomMargin: 11
        anchors.rightMargin: 12
        anchors.topMargin: 11
        path: "M 88.03125 3.5999999046325684 L 91.6312484741211 0 L 119.53125 0 L 119.53125 18.899999618530273 L 115.9312515258789 22.5 L 88.03125 22.5 L 88.03125 3.5999999046325684 Z M 103.02468872070312 20.607187271118164 L 105.11016082763672 19.635469436645508 L 105.10734558105469 19.635469436645508 L 103.4057846069336 16.901718139648438 C 104.1890658736229 16.375780642032623 104.75296476483345 15.612186968326569 105.09749603271484 14.613749504089355 C 105.43921479582787 13.615312039852142 105.61219024658203 12.304686784744263 105.61219024658203 10.684686660766602 C 105.61219024658203 8.227967977523804 105.19312590360641 6.406875491142273 104.35640716552734 5.225625514984131 C 103.51968842744827 4.044375538825989 102.06140875816345 3.4523441791534424 99.98297119140625 3.4523441791534424 C 97.90453362464905 3.4523441791534424 96.44343566894531 4.045781493186951 95.59968566894531 5.234062671661377 C 94.75593566894531 6.423750162124634 94.3354721069336 8.242030143737793 94.3354721069336 10.693123817443848 C 94.3354721069336 13.144217491149902 94.74890810251236 14.937187790870667 95.58000183105469 16.07062530517578 C 96.4125018119812 17.204062819480896 97.87921643257141 17.772188186645508 99.98577880859375 17.772188186645508 C 100.55249756574631 17.772188186645508 100.96452909708023 17.731407091021538 101.22046661376953 17.6512508392334 L 103.02327728271484 20.607187271118164 L 103.02468872070312 20.607187271118164 Z M 108.65250396728516 16.981874465942383 C 109.07719147205353 17.507811963558197 109.86468410491943 17.772188186645508 111.0121841430664 17.772188186645508 C 111.48468413949013 17.772188186645508 112.17374604940414 17.684999465942383 113.07796478271484 17.509218215942383 L 112.97672271728516 15.747186660766602 L 111.3159408569336 15.807657241821289 C 110.81672212481499 15.807657241821289 110.50593964010477 15.672656536102295 110.38500213623047 15.402656555175781 C 110.26406463235617 15.132656574249268 110.20218658447266 14.585624277591705 110.20218658447266 13.762968063354492 L 110.20218658447266 9.307969093322754 L 112.99641418457031 9.307969093322754 L 112.99641418457031 7.425000190734863 L 110.20218658447266 7.425000190734863 L 110.20218658447266 4.4887495040893555 L 108.01546478271484 4.4887495040893555 L 108.01546478271484 7.425000190734863 L 106.71891021728516 7.425000190734863 L 106.71891021728516 9.307969093322754 L 108.01546478271484 9.307969093322754 L 108.01546478271484 14.006250381469727 C 108.01546478271484 15.464531660079956 108.2264102101326 16.4559383392334 108.65250396728516 16.9832820892334 L 108.65250396728516 16.981874465942383 Z M 97.37578582763672 6.674062252044678 C 97.84828582406044 5.837343513965607 98.7187579870224 5.418281078338623 99.98860168457031 5.418281078338623 C 101.25844538211823 5.418281078338623 102.12609162926674 5.837343513965607 102.59156036376953 6.674062252044678 C 103.05562284588814 7.510780990123749 103.2890625 8.85374927520752 103.2890625 10.704374313354492 C 103.2890625 12.554999351501465 103.06406432390213 13.86562430858612 102.61125183105469 14.641874313354492 C 102.15703308582306 15.418124318122864 101.28375279903412 15.80484390258789 99.98719024658203 15.80484390258789 C 98.69062769412994 15.80484390258789 97.81312042474747 15.411093413829803 97.35468292236328 14.620780944824219 C 96.8962454199791 13.830468475818634 96.6656265258789 12.519843459129333 96.6656265258789 10.683280944824219 C 96.6656265258789 8.846718430519104 96.90187439322472 7.510780990123749 97.37437438964844 6.674062252044678 L 97.37578582763672 6.674062252044678 Z M 0 4.6687493324279785 L 5.085000514984131 4.6687493324279785 C 6.4546879529953 4.6687493324279785 7.477031230926514 4.945781171321869 8.15625 5.499843597412109 C 8.8340625166893 6.05390602350235 9.172967910766602 6.93703019618988 9.172967910766602 8.14921760559082 C 9.172967910766602 8.945155024528503 9.04640707373619 9.570937722921371 8.791875839233398 10.026562690734863 C 8.537344604730606 10.483593881130219 8.136562705039978 10.86046713590622 7.589531421661377 11.161404609680176 C 8.867812633514404 11.656404554843903 9.506250381469727 12.694217085838318 9.506250381469727 14.270623207092285 C 9.506250381469727 16.800466775894165 8.0845308303833 18.064687728881836 5.242499828338623 18.064687728881836 L 0.001406550407409668 18.064687728881836 L 0.001406550407409668 4.667344093322754 L 0 4.6687493324279785 Z M 4.9682817459106445 6.546093940734863 L 2.171250343322754 6.546093940734863 L 2.171250343322754 10.37952995300293 L 5.047031402587891 10.37952995300293 C 6.325312614440918 10.37952995300293 6.963750839233398 9.721404552459717 6.963750839233398 8.403748512268066 C 6.963750839233398 7.164842367172241 6.298594236373901 6.546093940734863 4.9682817459106445 6.546093940734863 Z M 5.085000514984131 12.217499732971191 L 2.171250343322754 12.217499732971191 L 2.171250343322754 16.187341690063477 L 5.124375343322754 16.187341690063477 C 5.841562807559967 16.187341690063477 6.378750532865524 16.036874055862427 6.737344264984131 15.737342834472656 C 7.095937997102737 15.437811613082886 7.274530410766602 14.92312341928482 7.274530410766602 14.191873550415039 C 7.274530410766602 13.460623681545258 7.066406071186066 12.950155258178711 6.648749828338623 12.656249046325684 C 6.23109358549118 12.363749086856842 5.709375083446503 12.216092109680176 5.083593845367432 12.216092109680176 L 5.085000514984131 12.217499732971191 Z M 17.641407012939453 8.287031173706055 L 19.75359535217285 8.287031173706055 L 19.75359535217285 18.06609535217285 L 17.641407012939453 18.06609535217285 L 17.641407012939453 17.46000099182129 C 16.68937575817108 18.008438527584076 15.809063911437988 18.28125 15.000470161437988 18.28125 C 13.657501339912415 18.28125 12.757501065731049 17.919844090938568 12.301876068115234 17.19562530517578 C 11.844844818115234 16.471406519412994 11.617033004760742 15.204375147819519 11.617033004760742 13.391718864440918 L 11.617033004760742 8.287031173706055 L 13.748908996582031 8.287031173706055 L 13.748908996582031 13.411406517028809 C 13.748908996582031 14.585625290870667 13.845939263701439 15.374532043933868 14.042814254760742 15.778125762939453 C 14.23828300833702 16.18312579393387 14.693908512592316 16.384218215942383 15.41250228881836 16.384218215942383 C 16.131096065044403 16.384218215942383 16.76250123977661 16.253437608480453 17.348907470703125 15.993281364440918 L 17.64281463623047 15.876562118530273 L 17.64281463623047 8.28843879699707 L 17.641407012939453 8.287031173706055 Z M 22.335468292236328 6.624844551086426 L 22.335468292236328 4.376251220703125 L 24.467342376708984 4.376251220703125 L 24.467342376708984 6.624844551086426 L 22.335468292236328 6.624844551086426 Z M 22.335468292236328 18.06609535217285 L 22.335468292236328 8.287031173706055 L 24.467342376708984 8.287031173706055 L 24.467342376708984 18.06609535217285 L 22.335468292236328 18.06609535217285 Z M 27.167343139648438 18.06609344482422 L 27.167343139648438 4.21875 L 29.299219131469727 4.21875 L 29.299219131469727 18.06609344482422 L 27.167343139648438 18.06609344482422 Z M 37.25859451293945 10.106719017028809 L 34.55999755859375 10.106719017028809 L 34.55999755859375 14.409845352172852 C 34.55999755859375 15.20578283071518 34.619060061872005 15.733125120401382 34.73577880859375 15.993281364440918 C 34.852497555315495 16.25484386086464 35.153436571359634 16.384218215942383 35.635780334472656 16.384218215942383 L 37.2389030456543 16.325157165527344 L 37.335933685302734 18.02672004699707 C 36.46265244483948 18.195470049977303 35.79749816656113 18.281251907348633 35.34187316894531 18.281251907348633 C 34.23374819755554 18.281251907348633 33.47296616435051 18.02672016620636 33.06374740600586 17.51906394958496 C 32.65312239527702 17.011407732963562 32.44780731201172 16.052344918251038 32.44780731201172 14.644688606262207 L 32.44780731201172 10.106719017028809 L 31.196247100830078 10.106719017028809 L 31.196247100830078 8.287031173706055 L 32.44780731201172 8.287031173706055 L 32.44780731201172 5.450626373291016 L 34.55999755859375 5.450626373291016 L 34.55999755859375 8.287031173706055 L 37.25859451293945 8.287031173706055 L 37.25859451293945 10.106719017028809 Z M 42.5390625 8.287031173706055 L 44.631561279296875 8.287031173706055 L 46.177032470703125 16.247812271118164 L 46.56796646118164 16.247812271118164 L 48.425621032714844 8.482501983642578 L 50.61515426635742 8.482501983642578 L 52.47421646118164 16.247812271118164 L 52.86515426635742 16.247812271118164 L 54.39093780517578 8.287031173706055 L 56.50312423706055 8.287031173706055 L 54.43031311035156 18.06609535217285 L 51.046875 18.06609535217285 L 49.52109146118164 11.358283042907715 L 47.99531173706055 18.06609535217285 L 44.611873626708984 18.06609535217285 L 42.5390625 8.287031173706055 Z M 58.32281494140625 6.624844551086426 L 58.32281494140625 4.376251220703125 L 60.45469665527344 4.376251220703125 L 60.45469665527344 6.624844551086426 L 58.32281494140625 6.624844551086426 Z M 58.32281494140625 18.06609535217285 L 58.32281494140625 8.287031173706055 L 60.45469665527344 8.287031173706055 L 60.45469665527344 18.06609535217285 L 58.32281494140625 18.06609535217285 Z M 68.2973403930664 10.106719017028809 L 65.59874725341797 10.106719017028809 L 65.59874725341797 14.409845352172852 C 65.59874725341797 15.20578283071518 65.65780975669622 15.733125120401382 65.77452850341797 15.993281364440918 C 65.89124725013971 16.25484386086464 66.19218626618385 16.384218215942383 66.67453002929688 16.384218215942383 L 68.27766418457031 16.325157165527344 L 68.37468719482422 18.02672004699707 C 67.50140595436096 18.195470049977303 66.83624786138535 18.281251907348633 66.38062286376953 18.281251907348633 C 65.27249789237976 18.281251907348633 64.51172730326653 18.02672016620636 64.10250854492188 17.51906394958496 C 63.69188353419304 17.011407732963562 63.48656463623047 16.052344918251038 63.48656463623047 14.644688606262207 L 63.48656463623047 10.106719017028809 L 62.23500061035156 10.106719017028809 L 62.23500061035156 8.287031173706055 L 63.48656463623047 8.287031173706055 L 63.48656463623047 5.450626373291016 L 65.59874725341797 5.450626373291016 L 65.59874725341797 8.287031173706055 L 68.2973403930664 8.287031173706055 L 68.2973403930664 10.106719017028809 Z M 72.16874694824219 18.06609344482422 L 70.036865234375 18.06609344482422 L 70.036865234375 4.21875 L 72.16874694824219 4.21875 L 72.16874694824219 8.796093940734863 C 73.13343447446823 8.313750177621841 74.0263985991478 8.071874618530273 74.84764862060547 8.071874618530273 C 76.15124249458313 8.071874618530273 77.04140105843544 8.440312027931213 77.51811981201172 9.177186965942383 C 77.99343234300613 9.914061903953552 78.23249816894531 11.130468487739563 78.23249816894531 12.824999809265137 L 78.23249816894531 18.06609344482422 L 76.10061645507812 18.06609344482422 L 76.10061645507812 12.88265609741211 C 76.10061645507812 11.826562285423279 75.98951904475689 11.07703110575676 75.76873779296875 10.63265609741211 C 75.54655028879642 10.189687341451645 75.076875269413 9.967500686645508 74.35968780517578 9.967500686645508 C 73.73390656709671 9.967500686645508 73.10811918973923 10.071562349796295 72.48233795166016 10.28109359741211 L 72.16874694824219 10.397812843322754 L 72.16874694824219 18.06609344482422 Z"
        strokeWidth: 1
    }
    states: [
        State {
            name: "state_color_Dark"
        },
        State {
            name: "state_color_Light"

            PropertyChanges {
                target: logo
                fillColor: "#000000"
            }

            PropertyChanges {
                target: background
                fillColor: "#ffffff"
            }
        }
    ]
}