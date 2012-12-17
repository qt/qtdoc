# Module dependencies.
# Every module that is required to build this module should have one entry.
# Each of the module version specifiers can take one of the following values:
#   - A specific Git revision.
#   - any git symbolic ref resolvable from the module's repository (e.g. "refs/heads/master" to track master branch)
#
%dependencies = (
    "qtbase" => "refs/heads/release",
    "qtscript" => "refs/heads/release",
    "qtsvg" => "refs/heads/release",
    "qtxmlpatterns" => "refs/heads/release",
    "qttools" => "refs/heads/release",
    "qtdeclarative" => "refs/heads/release",
    "qtjsbackend" => "refs/heads/release",
);
