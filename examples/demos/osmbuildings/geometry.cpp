// Copyright (C) 2023 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "geometry.h"

#include <QColor>
#include <QGeoPolygon>
#include <QRandomGenerator>
#include <QThreadPool>

QT_WARNING_PUSH
QT_WARNING_DISABLE_CLANG("-Wunused-but-set-variable")
QT_WARNING_DISABLE_GCC("-Wunused-but-set-variable")
#include "3rdparty/mapbox/earcut.h"
QT_WARNING_POP

using namespace Qt::StringLiterals;

OSMGeometry::OSMGeometry(QQuick3DGeometry *parent): QQuick3DGeometry{ parent }
{

}

void OSMGeometry::updateData(const QList<QVariant> &geoVariantsList)
{
    QThreadPool::globalInstance()->start([this, geoVariantsList](){
        loadGeometryFromData(geoVariantsList);
    });
}

static inline void writeIndex(uint32_t *&ibPtr, uint32_t i1, uint32_t i2, uint32_t i3)
{
    *ibPtr++ = i1;
    *ibPtr++ = i2;
    *ibPtr++ = i3;
}

static inline void writeVertex(float *&vbPtr, QVector3D pos, QVector3D normal,
                               QVector3D tangent, QVector3D binormal,
                               QColor color, float alpha,
                               float texCoordX, float texCoordY,
                               float levels, float isRoofTop)
{
    //position
    *vbPtr++ = pos.x();
    *vbPtr++ = pos.y();
    *vbPtr++ = pos.z();

    *vbPtr++ = normal.x();
    *vbPtr++ = normal.y();
    *vbPtr++ = normal.z();

           //tangent
    *vbPtr++ = tangent.x();
    *vbPtr++ = tangent.y();
    *vbPtr++ = tangent.z();

           //binormal
    *vbPtr++ = binormal.x();
    *vbPtr++ = binormal.y();
    *vbPtr++ = binormal.z();

    *vbPtr++ = color.redF();
    *vbPtr++ = color.greenF();
    *vbPtr++ = color.blueF();
    *vbPtr++ = alpha;

           //texcoord
    *vbPtr++ = texCoordX;
    *vbPtr++ = texCoordY;

    *vbPtr++ = levels;
    *vbPtr++ = isRoofTop;
}

void OSMGeometry::loadGeometryFromData(const QList<QVariant> &geoVariantsList)
{
    constexpr int strideVertexLen = 20;
    /* 3 Position + 3 Normal + 3 Tangent + 3 Binormal + 4 Color + 2 Texcoord0
       + 2 Texcoord1 as Number of Levels and Is Rooftop */
    constexpr int strideVertex = strideVertexLen * sizeof(float);
    constexpr auto convertGeoCoordToVertexPosition = [](const float lat, const float lon) -> QVector3D {

        const double scale = 1.212;
        const double geoToPositionScale = 1000000 * scale;
        const double XOffsetFromCenter = 537277 * scale;
        const double YOffsetFromCenter = 327957 * scale;
        double x = (lon/360.0 + 0.5) * geoToPositionScale;
        double y = (1.0-log(qTan(qDegreesToRadians(lat)) + 1.0 / qCos(qDegreesToRadians(lat))) / M_PI) * 0.5 * geoToPositionScale;
        return QVector3D( x - XOffsetFromCenter, YOffsetFromCenter - y, 0.0 );
    };

    constexpr int stridePrimitive = 3 * sizeof(uint32_t);

    QByteArray vertexData;
    QByteArray indexData;

    const float maxFloat = std::numeric_limits<float>::max();
    const float minFloat = std::numeric_limits<float>::min();

    QVector3D meshMinBound = QVector3D(maxFloat, maxFloat, maxFloat);
    QVector3D meshMaxBound = QVector3D(minFloat, minFloat, minFloat);

    qsizetype globalVertexCounter = 0;
    qsizetype globalPrimitiveCounter = 0;

    for ( const QVariant &baseData : geoVariantsList ) {
        for ( const QVariant &dataValue : baseData.toMap()["data"_L1].toList() ) {
            const auto featureMap = dataValue.toMap();
            const auto properties = featureMap["properties"_L1].toMap();
            const auto buildingCoords = featureMap["data"_L1].value<QGeoPolygon>().perimeter();
            float height = 0.15 * properties["height"_L1].toLongLong();
            float levels = static_cast<float>(properties["levels"_L1].toLongLong());
            QColor color = QColor::fromString( properties["color"_L1].toString());
            if ( !color.isValid() || color == QColor(Qt::GlobalColor::black))
                color = QColor(Qt::GlobalColor::white);
            QColor roofColor = QColor::fromString( properties["roofColor"_L1].toString());
            if ( !roofColor.isValid() || roofColor == QColor(Qt::GlobalColor::black) )
                roofColor = color;

            QVector3D subsetMinBound = QVector3D(maxFloat, maxFloat, maxFloat);
            QVector3D subsetMaxBound = QVector3D(minFloat, minFloat, minFloat);

            qsizetype numSubsetVertices = buildingCoords.size() * 2;
            qsizetype lastVertexDataCount = vertexData.size();
            qsizetype lastIndexDataCount = indexData.size();
            vertexData.resize( lastVertexDataCount + numSubsetVertices * strideVertex );
            indexData.resize( lastIndexDataCount + ( numSubsetVertices - 2 ) * stridePrimitive );

            float *vbPtr = &reinterpret_cast<float *>(vertexData.data())[globalVertexCounter * strideVertexLen];
            uint32_t *ibPtr = &reinterpret_cast<uint32_t *>(indexData.data())[globalPrimitiveCounter * 3];

            qsizetype subsetVertexCounter = 0;

            QVector3D lastBaseVertexPos;
            QVector3D lastExtrudedVertexPos;
            QVector3D currentBaseVertexPos;
            QVector3D currentExtrudedVertexPos;
            QVector3D subsetPolygonCenter;

            using PolygonVertex = std::array<double, 2>;
            using PolygonVertices = std::vector<PolygonVertex>;

            PolygonVertices roofPolygonVertices;

            for ( const QGeoCoordinate &buildingPoint : buildingCoords ) {

                lastBaseVertexPos = currentBaseVertexPos;
                lastExtrudedVertexPos = currentExtrudedVertexPos;

                currentBaseVertexPos = convertGeoCoordToVertexPosition( buildingPoint.latitude(), buildingPoint.longitude() );
                currentExtrudedVertexPos = QVector3D(currentBaseVertexPos.x(), currentBaseVertexPos.y(), height);

                roofPolygonVertices.push_back( {currentBaseVertexPos.x(),currentBaseVertexPos.y()} );
                subsetPolygonCenter.setX( subsetPolygonCenter.x() + currentBaseVertexPos.x() );
                subsetPolygonCenter.setY( subsetPolygonCenter.y() + currentBaseVertexPos.y() );

                meshMinBound.setX( qMin( meshMinBound.x(), currentBaseVertexPos.x() ) );
                meshMinBound.setY( qMin( meshMinBound.y(), currentBaseVertexPos.y() ) );
                meshMinBound.setZ( qMin( meshMinBound.z(), currentBaseVertexPos.z() ) );

                meshMaxBound.setX( qMax( meshMaxBound.x(), currentExtrudedVertexPos.x() ) );
                meshMaxBound.setY( qMax( meshMaxBound.y(), currentExtrudedVertexPos.y() ) );
                meshMaxBound.setZ( qMax( meshMaxBound.z(), currentExtrudedVertexPos.z() ) );

                subsetMinBound.setX( qMin( subsetMinBound.x(), currentBaseVertexPos.x() ) );
                subsetMinBound.setY( qMin( subsetMinBound.y(), currentBaseVertexPos.y() ) );
                subsetMinBound.setZ( qMin( subsetMinBound.z(), currentBaseVertexPos.z() ) );

                subsetMaxBound.setX( qMax( subsetMaxBound.x(), currentExtrudedVertexPos.x() ) );
                subsetMaxBound.setY( qMax( subsetMaxBound.y(), currentExtrudedVertexPos.y() ) );
                subsetMaxBound.setZ( qMax( subsetMaxBound.z(), currentExtrudedVertexPos.z() ) );

                if ( subsetVertexCounter < numSubsetVertices - 2 ) {
                    writeIndex(ibPtr, globalVertexCounter + 3, globalVertexCounter + 2,
                               globalVertexCounter + 0);
                    writeIndex(ibPtr, globalVertexCounter + 1, globalVertexCounter + 3,
                               globalVertexCounter + 0);
                    globalPrimitiveCounter += 2;
                }

                if ( subsetVertexCounter == 2 ) {

                    QVector3D tangent = (currentExtrudedVertexPos - currentBaseVertexPos).normalized();
                    QVector3D binormal = (lastBaseVertexPos - currentBaseVertexPos).normalized();
                    QVector3D normal = QVector3D::crossProduct( binormal, tangent).normalized();

                    writeVertex(vbPtr, lastBaseVertexPos, normal, tangent, binormal, color,
                                1.0F, 0.0F, 0.0F, levels, 0.0F);
                    writeVertex(vbPtr, lastExtrudedVertexPos, normal, tangent, binormal, color,
                                1.0F, 0.0F, 1.0F, levels, 0.0F);
                }

                if ( subsetVertexCounter >= 2 ) {

                    QVector3D tangent = (currentExtrudedVertexPos - currentBaseVertexPos).normalized();
                    QVector3D binormal = (lastBaseVertexPos - currentBaseVertexPos).normalized();
                    QVector3D normal = QVector3D::crossProduct( binormal, tangent).normalized();

                    const float xCoord = ( subsetVertexCounter % 4 != 0) ? 1.0F : 0.0F;

                    writeVertex(vbPtr, currentBaseVertexPos, normal, tangent, binormal, color,
                                1.0, xCoord, 0.0, levels, 0.0);
                    writeVertex(vbPtr, currentExtrudedVertexPos, normal, tangent, binormal, color,
                                1.0, xCoord, 1.0, levels, 0.0);
                }

                subsetVertexCounter += 2;
                globalVertexCounter += 2;

            }

            const auto shape = properties["shape"_L1].toString();
            {

                if ( shape == "sphere"_L1) {

                    subsetPolygonCenter = QVector3D(subsetPolygonCenter.x() / roofPolygonVertices.size(),
                                                    subsetPolygonCenter.y() / roofPolygonVertices.size(), height );

                    float sphereRadius = 2.0F * qAbs(roofPolygonVertices[0][0] - subsetPolygonCenter.x());

                    sphereRadius = qMax(sphereRadius, 1.0);
                    float sphereRadiuslengthInv = 1.0F / sphereRadius;

                    const uint32_t sphereSectorCount = 10;
                    const uint32_t sphereStackCount = 10;

                    constexpr double sphereSectorStep = 2.0 * M_PI / sphereSectorCount;
                    constexpr double sphereStackStep = M_PI / sphereStackCount;

                    lastVertexDataCount = vertexData.size();
                    lastIndexDataCount = indexData.size();
                    uint32_t sphereVertexCount = (sphereStackCount + 1) * (sphereSectorCount + 1);
                    uint32_t indexCount = 2 * (sphereStackCount - 1) * (sphereSectorCount + 1)
                            + 2 * (sphereSectorCount + 1); // one index only in first/last stack
                    vertexData.resize( lastVertexDataCount + sphereVertexCount * strideVertex );
                    indexData.resize( lastIndexDataCount + indexCount * 3 * sizeof(uint32_t) );
                    vbPtr = &reinterpret_cast<float *>(vertexData.data())[globalVertexCounter * strideVertexLen];
                    ibPtr = &reinterpret_cast<uint32_t *>(indexData.data())[globalPrimitiveCounter * 3];

                    for (uint32_t stackIndex = 0; stackIndex <= sphereStackCount; ++stackIndex) {
                        float k1 = stackIndex * (sphereSectorCount + 1);
                        float k2 = k1 + sphereSectorCount + 1;

                        const float sphereStackAngle = M_PI / 2.0 - stackIndex * sphereStackStep;
                        float xy = sphereRadius * qCos(sphereStackAngle);
                        float z = sphereRadius * qSin(sphereStackAngle);

                        for (uint32_t sectorIndex = 0; sectorIndex <= sphereSectorCount; ++sectorIndex,  ++k1, ++k2) {
                            if (stackIndex != 0) {
                                writeIndex(ibPtr, k1 + globalVertexCounter,
                                           k2 + globalVertexCounter, k1 + 1 + globalVertexCounter);
                                ++globalPrimitiveCounter;
                            }

                            if (stackIndex != (sphereStackCount-1)) {
                                writeIndex(ibPtr, k1 + 1 + globalVertexCounter,
                                           k2 + globalVertexCounter, k2 + 1 + globalVertexCounter);
                                ++globalPrimitiveCounter;
                            }

                            const float sphereSectorAngle = sectorIndex * sphereSectorStep;

                            float x = xy * qCos(sphereSectorAngle);
                            float y = xy * qSin(sphereSectorAngle);

                            QVector3D position{x + subsetPolygonCenter.x(),
                                               y + subsetPolygonCenter.y(),
                                               z + subsetPolygonCenter.z()};

                            QVector3D normal{x * sphereRadiuslengthInv,
                                             y * sphereRadiuslengthInv,
                                             z * sphereRadiuslengthInv};
                            QVector3D tangent{0.0F, 0.0F, 0.0F};
                            QVector3D binormal{0.0F, 0.0F, 0.0F};
                            writeVertex(vbPtr, position, normal, tangent, binormal, roofColor,
                                        1.0F, 1.0F, 1.0F, 0.0F, 1.0F);
                        }
                    }
                    subsetVertexCounter += sphereVertexCount;
                    globalVertexCounter += sphereVertexCount;
                }
                {

                    std::vector<PolygonVertices> roofPolygonsVertices;
                    roofPolygonsVertices.push_back( roofPolygonVertices );
                    std::vector<uint32_t> roofIndices = mapbox::earcut<uint32_t>(roofPolygonsVertices);

                    lastVertexDataCount = vertexData.size();
                    lastIndexDataCount = indexData.size();
                    vertexData.resize( lastVertexDataCount + roofPolygonVertices.size() * strideVertex );
                    indexData.resize( lastIndexDataCount + roofIndices.size() * sizeof(uint32_t) );

                    vbPtr = &reinterpret_cast<float *>(vertexData.data())[globalVertexCounter * strideVertexLen];
                    ibPtr = &reinterpret_cast<uint32_t *>(indexData.data())[globalPrimitiveCounter * 3];

                    for ( const uint32_t &roofIndex : roofIndices ) {
                        *ibPtr++ = roofIndex + globalVertexCounter;
                    }
                    qsizetype roofPrimitiveCount = roofIndices.size() / 3;
                    globalPrimitiveCounter += roofPrimitiveCount;

                    for ( const PolygonVertex &polygonVertex : roofPolygonVertices ) {
                        QVector3D position{float(polygonVertex.at(0)),
                                           float(polygonVertex.at(1)), height};
                        QVector3D normal{0.0F, 0.0F, 1.0F};
                        QVector3D tangent{1.0F, 0.0F, 0.0F};
                        QVector3D binormal{0.0F, 1.0F, 0.0F};
                        writeVertex(vbPtr, position, normal, tangent, binormal, roofColor,
                                    1.0F, 1.0F, 1.0F, 0.0F, 1.0F);
                        ++subsetVertexCounter;
                        ++globalVertexCounter;
                    }

                }

            }
        }
    }

    clear();

    setIndexData(indexData);

    setVertexData(vertexData);

    setStride(strideVertex);

    setBounds(meshMinBound, meshMaxBound);

    setPrimitiveType(QQuick3DGeometry::PrimitiveType::Triangles);

    addAttribute(QQuick3DGeometry::Attribute::IndexSemantic, 0, QQuick3DGeometry::Attribute::U32Type);

    addAttribute(QQuick3DGeometry::Attribute::PositionSemantic, 0, QQuick3DGeometry::Attribute::F32Type);

    addAttribute(QQuick3DGeometry::Attribute::NormalSemantic, 3 * sizeof(float), QQuick3DGeometry::Attribute::F32Type);

    addAttribute(QQuick3DGeometry::Attribute::TangentSemantic, 6 * sizeof(float), QQuick3DGeometry::Attribute::F32Type);

    addAttribute(QQuick3DGeometry::Attribute::BinormalSemantic, 9 * sizeof(float), QQuick3DGeometry::Attribute::F32Type);

    addAttribute(QQuick3DGeometry::Attribute::ColorSemantic, 12 * sizeof(float), QQuick3DGeometry::Attribute::F32Type);

    addAttribute(QQuick3DGeometry::Attribute::TexCoord0Semantic, 16 * sizeof(float), QQuick3DGeometry::Attribute::F32Type);

    addAttribute(QQuick3DGeometry::Attribute::TexCoord1Semantic, 18 * sizeof(float), QQuick3DGeometry::Attribute::F32Type);

    update();

    emit geometryReady();

}

