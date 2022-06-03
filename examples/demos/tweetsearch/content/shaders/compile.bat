:: Copyright (C) 2020 The Qt Company Ltd.
:: SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

qsb --glsl "150,120,100 es" --hlsl 50 --msl 12 -c -o effect.frag.qsb effect.frag
qsb -b --glsl "150,120,100 es" --hlsl 50 --msl 12 -c -o effect.vert.qsb effect.vert
