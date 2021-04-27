//
//  GifModel.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/30/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import Foundation

struct GifDataModel: Decodable {
    let data: GifItemModel
}

struct GifSearchDataModel: Decodable {
    let data: [GifItemModel]
}

struct GifItemModel: Decodable {
    
    let title: String
    let rating: String
    let images: GifImageModel
}

struct GifImageModel: Decodable {
    
    let fixedWidth: GifOriginalModel
    let fixedWidthStill: GifOriginalModel
}

struct GifOriginalModel: Decodable {
    let url: String
}
