//
//  Vetices.m
//  RattleGLES
//
//  Created by Max Bilbow on 24/03/2015.
//  Copyright (c) 2015 Rattle Media Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

#import "Vertices.h"
/**
 Vertex for cube
 */
/*
Vertex VerticesCube[] = {
    // Front
    {{1, -1, 1},    {1, 0, 0, 1}, {0, 1},               {0, 0, 1}},
    {{1, 1, 1},     {0, 1, 0, 1}, {0, 2.0/3.0},         {0, 0, 1}},
    {{-1, 1, 1},    {0, 0, 1, 1}, {1.0/3.0, 2.0/3.0},   {0, 0, 1}},
    {{-1, -1, 1},   {0, 0, 0, 1}, {1.0/3.0, 1},         {0, 0, 1}},
    // Back
    {{1, 1, -1},    {1, 0, 0, 1}, {1.0/3.0, 1},         {0, 0, -1}},
    {{1, -1, -1},   {0, 0, 1, 1}, {1.0/3.0, 2.0/3.0},   {0, 0, -1}},
    {{-1, -1, -1},  {0, 1, 0, 1}, {2.0/3.0, 2.0/3.0},   {0, 0, -1}},
    {{-1, 1, -1},   {0, 0, 0, 1}, {2.0/3.0, 1},         {0, 0, -1}},
    // Left
    {{-1, -1, 1},   {1, 0, 0, 1}, {2.0/3.0, 1},         {-1, 0, 0}},
    {{-1, 1, 1},    {0, 1, 0, 1}, {2.0/3.0, 2.0/3.0},   {-1, 0, 0}},
    {{-1, 1, -1},   {0, 0, 1, 1}, {1, 2.0/3.0},         {-1, 0, 0}},
    {{-1, -1, -1},  {0, 0, 0, 1}, {1, 1},               {-1, 0, 0}},
    // Right
    {{1, -1, -1},   {1, 0, 0, 1}, {0, 2.0/3.0},         {1, 0, 0}},
    {{1, 1, -1},    {0, 1, 0, 1}, {0, 1.0/3.0},         {1, 0, 0}},
    {{1, 1, 1},     {0, 0, 1, 1}, {1.0/3.0, 1.0/3.0},   {1, 0, 0}},
    {{1, -1, 1},    {0, 0, 0, 1}, {1.0/3.0, 2.0/3.0},   {1, 0, 0}},
    // Top
    {{1, 1, 1},     {1, 0, 0, 1}, {1.0/3.0, 2.0/3.0},   {0, 1, 0}},
    {{1, 1, -1},    {0, 1, 0, 1}, {1.0/3.0, 1.0/3.0},   {0, 1, 0}},
    {{-1, 1, -1},   {0, 0, 1, 1}, {2.0/3.0, 1.0/3.0},   {0, 1, 0}},
    {{-1, 1, 1},    {0, 0, 0, 1}, {2.0/3.0, 2.0/3.0},   {0, 1, 0}},
    // Bottom
    {{1, -1, -1},   {1, 0, 0, 1}, {2.0/3.0, 2.0/3.0},   {0, -1, 0}},
    {{1, -1, 1},    {0, 1, 0, 1}, {2.0/3.0, 1.0/3.0},   {0, -1, 0}},
    {{-1, -1, 1},   {0, 0, 1, 1}, {1, 1.0/3.0},         {0, -1, 0}},
    {{-1, -1, -1},  {0, 0, 0, 1}, {1, 2.0/3.0},         {0, -1, 0}}
};

GLubyte IndicesTrianglesCube[] = {
    // Front
    0, 1, 2,
    2, 3, 0,
    // Back
    4, 6, 5,
    4, 6, 7,
    // Left
    8, 9, 10,
    10, 11, 8,
    // Right
    12, 13, 14,
    14, 15, 12,
    // Top
    16, 17, 18,
    18, 19, 16,
    // Bottom
    20, 21, 22,
    22, 23, 20
};

///Plane


Vertex VerticesPlane[] = {
    // Top
    {{1, 0, 1},     {1, 0, 0, 1}, {1.0/3.0, 2.0/3.0},   {0, 1, 0}},
    {{1, 0, -1},    {0, 1, 0, 1}, {1.0/3.0, 1.0/3.0},   {0, 1, 0}},
    {{-1, 0, -1},   {0, 0, 1, 1}, {2.0/3.0, 1.0/3.0},   {0, 1, 0}},
    {{-1, 0, 1},    {0, 0, 0, 1}, {2.0/3.0, 2.0/3.0},   {0, 1, 0}},
    // Bottom
    {{1, 0, 1},     {1, 0, 0, 1}, {1.0/3.0, 2.0/3.0},   {0, -1, 0}},
    {{1, 0, -1},    {0, 1, 0, 1}, {1.0/3.0, 1.0/3.0},   {0, -1, 0}},
    {{-1, 0, -1},   {0, 0, 1, 1}, {2.0/3.0, 1.0/3.0},   {0, -1, 0}},
    {{-1, 0, 1},    {0, 0, 0, 1}, {2.0/3.0, 2.0/3.0},   {0, -1, 0}},
};

GLubyte IndicesTrianglesPlane[] = {
    // Top
    0, 1, 2,
    2, 3, 0,
    // Bottom
    4, 6, 5,
    4, 6, 7,
};
 */
