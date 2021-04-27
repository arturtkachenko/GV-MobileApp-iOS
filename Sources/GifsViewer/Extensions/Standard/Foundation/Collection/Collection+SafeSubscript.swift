//
//  Collection+SafeSubscript.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 3/4/20.
//  Copyright © 2020 Arthur Tkachenko. All rights reserved.
//

import Foundation

extension Collection {

    subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
