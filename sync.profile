%modules = ( # path to module name map
    "QtDoc" => "$basedir/modules",  # point to an invalid directory in this case
);
%modulepris = (
    "QtDoc" => "$basedir/modules/qt_doc.pri",
);
# Modules and programs, and their dependencies.
# Each of the module version specifiers can take one of the following values:
#   - A specific Git revision.
#   - "LATEST_REVISION", to always test against the latest revision.
#   - "LATEST_RELEASE", to always test against the latest public release.
#   - "THIS_REPOSITORY", to indicate that the module is in this repository.
%dependencies = (
    "qdoc3" => {
        "QtXml" => "0c637cb07ba3c9b353e7e483a209537485cc4e2a",
        "QtCore" => "0c637cb07ba3c9b353e7e483a209537485cc4e2a",
    },
    "qtdemo" => {
        "QtHelp" => "b0b8ea45a2d33fa5f1ad5970e6640ef3a3f325a3",
        "QtXml" => "0c637cb07ba3c9b353e7e483a209537485cc4e2a",
        "QtOpenGL" => "0c637cb07ba3c9b353e7e483a209537485cc4e2a",
        "QtDeclarative" => "90ff2cdea3126bdff2746ecf868004711ea628b1",
        "QtScript" => "4d15ca64fc7ca81bdadba9fbeb84d4e98a6c0edc",
        "QtSvg" => "1a71611b6ceaf6cdb24ea485a818fc56c956b5f8",
        "QtGui" => "0c637cb07ba3c9b353e7e483a209537485cc4e2a",
        "QtXmlPatterns" => "26edd6852a62aeec49712a53dcc8d4093192301c",
        "QtNetwork" => "0c637cb07ba3c9b353e7e483a209537485cc4e2a",
        "QtSql" => "0c637cb07ba3c9b353e7e483a209537485cc4e2a",
        "QtCore" => "0c637cb07ba3c9b353e7e483a209537485cc4e2a",
    },
);
