//
//  SizeCalculatable.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/31/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import UIKit

protocol SizeCalculatable: class {
    static func estimatedSize(from containerSize: CGSize) -> CGSize
}
