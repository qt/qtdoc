// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import "tweetsearch.mjs" as Helper

Item {
    id: wrapper

    // Insert valid consumer key and secret tokens below
    // See https://dev.twitter.com/apps
//! [auth tokens]
    property string consumerKey : ""
    property string consumerSecret : ""
//! [auth tokens]
    property string bearerToken : ""

    property variant model: tweets
    property string from : ""
    property string phrase : ""

    signal isLoaded

    ListModel { id: tweets }

    function encodePhrase(x) { return encodeURIComponent(x); }

    function reload() {
        tweets.clear()

        if (from === "" && phrase === "")
            return;

//! [requesting]
        var req = new XMLHttpRequest;
        req.open("GET", "https://api.twitter.com/1.1/search/tweets.json?from=" + from +
                        "&count=10&q=" + encodePhrase(phrase));
        req.setRequestHeader("Authorization", "Bearer " + bearerToken);
        req.onload = function() {
            var objectArray = JSON.parse(req.responseText);
            if (objectArray.errors !== undefined) {
                console.log("Error fetching tweets: " + objectArray.errors[0].message)
            } else {
                for (var key in objectArray.statuses) {
                    var jsonObject = objectArray.statuses[key];
                    var cleanJsonObject = {};
                    // iterate through the json objects
                    // and drop those with 'null' values.
                    for (var subkey in jsonObject)
                        if (jsonObject[subkey] !== null)
                            cleanJsonObject[subkey] = jsonObject[subkey]
                    tweets.append(cleanJsonObject);
                }
            }
            wrapper.isLoaded()
        }
        req.send();
//! [requesting]
    }

    onPhraseChanged: reload();
    onFromChanged: reload();

    Component.onCompleted: {
        if (consumerKey === "" || consumerSecret == "") {
            bearerToken = encodeURIComponent(Helper.demoToken())
            return;
        }

        var authReq = new XMLHttpRequest;
        authReq.open("POST", "https://api.twitter.com/oauth2/token");
        authReq.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
        authReq.setRequestHeader("Authorization", "Basic " + Qt.btoa(consumerKey + ":" + consumerSecret));
        authReq.onreadystatechange = function() {
            if (authReq.readyState === XMLHttpRequest.DONE) {
                var jsonResponse = JSON.parse(authReq.responseText);
                if (jsonResponse.errors !== undefined)
                    console.log("Authentication error: " + jsonResponse.errors[0].message)
                else
                    bearerToken = jsonResponse.access_token;
            }
        }
        authReq.send("grant_type=client_credentials");
    }

}
