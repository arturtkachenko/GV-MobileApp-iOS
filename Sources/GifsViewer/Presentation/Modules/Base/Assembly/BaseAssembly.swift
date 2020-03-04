//
//  BaseAssembly.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/30/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import Foundation

class BaseAssembly<ViewController: BaseViewController> {
    
    class func createModule(_ viewModel: GifItemViewModel? = nil) -> ViewController {
        return ViewController()
    }
}
