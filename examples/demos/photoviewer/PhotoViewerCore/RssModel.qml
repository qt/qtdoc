// Copyright (C) 2016 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQml.XmlListModel

XmlListModel {
    property string tags : ""

    function encodeTags(x) { return encodeURIComponent(x.replace(' ',',')); }

    source: "http://api.flickr.com/services/feeds/photos_public.gne?"+(tags ? "tags="+encodeTags(tags)+"&" : "")

    query: "/feed/entry"

    XmlListModelRole { name: "title"; elementName: "title"; attributeName: "" }
    XmlListModelRole { name: "link"; elementName: "link"; attributeName: "href" }
}
