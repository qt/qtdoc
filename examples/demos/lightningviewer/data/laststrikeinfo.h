// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#ifndef LASTSTRIKEINFO_H
#define LASTSTRIKEINFO_H


struct LastStrikeInfo
{
    double distance {-1};
    long long timestamp {0};
    double direction {0};

    LastStrikeInfo() { }
    inline LastStrikeInfo(double distance, long long timestamp, double direction);
    inline LastStrikeInfo(const LastStrikeInfo &other);

    bool isValid() const { return !(distance < 0.0); }
    inline bool operator<(const LastStrikeInfo &other) const;
    inline void operator=(const LastStrikeInfo &other);
};


LastStrikeInfo::LastStrikeInfo(double distance, long long timestamp, double direction)
    : distance(distance)
    , timestamp(timestamp)
    , direction(direction)
{ }

LastStrikeInfo::LastStrikeInfo(const LastStrikeInfo &other)
    : LastStrikeInfo(other.distance, other.timestamp, other.direction)
{ }

bool LastStrikeInfo::operator<(const LastStrikeInfo &other) const
{
    if (!other.isValid())
        return true;

    if (!isValid())
        return false;

    if (distance < other.distance)
        return true;

    if (distance > other.distance)
        return false;

    return timestamp > other.timestamp;
}

void LastStrikeInfo::operator=(const LastStrikeInfo &other)
{
    distance = other.distance;
    timestamp = other.timestamp;
    direction = other.direction;
}

#endif // LASTSTRIKEINFO_H
