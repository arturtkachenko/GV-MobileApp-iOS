//
//  GifSearchScreenModel.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 27.04.21.
//  Copyright © 2021 Arthur Tkachenko. All rights reserved.
//

import Foundation

struct GifSearchScreenModel {
    
    let items: [GifItemModel]
    let onSelectActionTriggered: ArgumentedClosure<Int>
}
