//
//  GifViewModel.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/31/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import Foundation

struct GifItemViewModel {
    let gifTitle: String
    let gifUrl: String
    let gifImageUrl: String
    let gifAgeRestriction: String
}

extension GifItemViewModel {
    
    init(_ model: GifItemModel) {
        gifTitle = model.title
        gifUrl = model.images.fixedWidth.url
        gifImageUrl = model.images.fixedWidthStill.url
        gifAgeRestriction = model.rating
    }
}
