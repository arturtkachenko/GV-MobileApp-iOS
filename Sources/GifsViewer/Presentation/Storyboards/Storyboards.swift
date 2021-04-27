//
//  Storyboards.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/30/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import UIKit

enum Storyboards: String {
    
    case gifSearch = "GifSearch"
    case gifDetails = "GifDetails"

    var controller: UIViewController {
        let storyboard = UIStoryboard(name: rawValue, bundle: nil)
        return storyboard.instantiateInitialViewController()!
    }
}
