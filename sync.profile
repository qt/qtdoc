%modules = ( # path to module name map
    "QtDoc" => "$basedir/modules",  # point to an invalid directory in this case
);
%modulepris = (
    "QtDoc" => "$basedir/modules/qt_doc.pri",
);
# Module dependencies.
# Every module that is required to build this module should have one entry.
# Each of the module version specifiers can take one of the following values:
#   - A specific Git revision.
#   - any git symbolic ref resolvable from the module's repository (e.g. "refs/heads/master" to track master branch)
#
%dependencies = (
    "qtbase" => "refs/heads/master",
    "qtscript" => "refs/heads/master",
    "qtsvg" => "refs/heads/master",
    "qtxmlpatterns" => "refs/heads/master",
    "qttools" => "refs/heads/master",
);
