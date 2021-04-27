//
//  GifSearchScreenViewModel.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 27.04.21.
//  Copyright © 2021 Arthur Tkachenko. All rights reserved.
//

import Foundation

struct GifSearchScreenViewModel {
    
    let items: [GifItemViewModel]
    let onSelectActionTriggered: ArgumentedClosure<Int>
    
    init(items: [GifItemViewModel], onSelectActionTriggered: @escaping ArgumentedClosure<Int>) {
        self.items = items
        self.onSelectActionTriggered = onSelectActionTriggered
    }
}
