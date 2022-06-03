// Copyright (C) 2017 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause
import QtQuick

ListModel {
    id: stocks

    // pre-fetch data for all entries
    Component.onCompleted: {
        for (var idx = 0; idx < count; ++idx) {
            getCloseValue(idx)
        }
    }

    function getCloseValue(index) {

        var endDate = new Date(); // today
        var startDate = new Date();
        endDate.setDate(startDate.getDate() - 1);
        startDate.setDate(endDate.getDate() - 7);

        var req = "data/" + get(index).stockId + ".csv"

        var xhr = new XMLHttpRequest;

        xhr.open("GET", req, true);

        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.LOADING || xhr.readyState === XMLHttpRequest.DONE) {
                var records = xhr.responseText.split('\n');
                var unknown = "n/a";
                set(index, {"value": unknown, "change": unknown, "changePercentage": unknown});
                if (records.length > 0 && xhr.status == 200) {
                    var r = records[1].split(',');
                    var today = parseFloat(r[4]);

                    if (!isNaN(today))
                        setProperty(index, "value", today.toFixed(2));
                    if (records.length > 2) {
                        r = records[2].split(',');
                        var yesterday = parseFloat(r[4]);
                        var change = today - yesterday;

                        if (change >= 0.0)
                            setProperty(index, "change", "+" + change.toFixed(2));
                        else
                            setProperty(index, "change", change.toFixed(2));

                        var changePercentage = (change / yesterday) * 100.0;
                        if (changePercentage >= 0.0)
                            setProperty(index, "changePercentage", "+" + changePercentage.toFixed(2) + "%");
                        else
                            setProperty(index, "changePercentage", changePercentage.toFixed(2) + "%");
                    }
                }
            }
        }
        xhr.send()
    }
    // Uncomment to test invalid entries
    // ListElement {name: "The Qt Company"; stockId: "TQTC"; value: "999.0"; change: "0.0"; changePercentage: "0.0"}

    // Offline data downloaded using the url, https://www.quandl.com/api/v3/datasets/WIKI/<stockId>.csv.
    ListElement {name: "Advanced Micro Devices Inc."; stockId: "AMD"; value: "0.0"; change: "0.0"; changePercentage: "0.0"}
    ListElement {name: "Amazon.com Inc."; stockId: "AMZN"; value: "0.0"; change: "0.0"; changePercentage: "0.0"}
    ListElement {name: "Apple Inc."; stockId: "AAPL"; value: "0.0"; change: "0.0"; changePercentage: "0.0"}
    ListElement {name: "Autodesk Inc."; stockId: "ADSK"; value: "0.0"; change: "0.0"; changePercentage: "0.0"}
    ListElement {name: "Cisco Systems Inc."; stockId: "CSCO"; value: "0.0"; change: "0.0"; changePercentage: "0.0"}
    ListElement {name: "eBay Inc."; stockId: "EBAY"; value: "0.0"; change: "0.0"; changePercentage: "0.0"}
    ListElement {name: "Electronic Arts Inc."; stockId: "EA"; value: "0.0"; change: "0.0"; changePercentage: "0.0"}
    ListElement {name: "Intel Corp."; stockId: "INTC"; value: "0.0"; change: "0.0"; changePercentage: "0.0"}
    ListElement {name: "Microsoft Corp."; stockId: "MSFT"; value: "0.0"; change: "0.0"; changePercentage: "0.0"}
    ListElement {name: "NetApp Inc."; stockId: "NTAP"; value: "0.0"; change: "0.0"; changePercentage: "0.0"}
    ListElement {name: "Netflix Inc."; stockId: "NFLX"; value: "0.0"; change: "0.0"; changePercentage: "0.0"}
    ListElement {name: "Norwegian Cruise Line Holdings Ltd."; stockId: "NCLH"; value: "0.0"; change: "0.0"; changePercentage: "0.0"}
    ListElement {name: "NVIDIA Corp."; stockId: "NVDA"; value: "0.0"; change: "0.0"; changePercentage: "0.0"}
    ListElement {name: "PayPal Holdings Inc."; stockId: "PYPL"; value: "0.0"; change: "0.0"; changePercentage: "0.0"}
    ListElement {name: "QUALCOMM Inc."; stockId: "QCOM"; value: "0.0"; change: "0.0"; changePercentage: "0.0"}
    ListElement {name: "Tesla Motors Inc."; stockId: "TSLA"; value: "0.0"; change: "0.0"; changePercentage: "0.0"}
    ListElement {name: "Texas Instruments Inc."; stockId: "TXN"; value: "0.0"; change: "0.0"; changePercentage: "0.0"}
    ListElement {name: "Facebook Inc."; stockId: "FB"; value: "0.0"; change: "0.0"; changePercentage: "0.0"}
}

