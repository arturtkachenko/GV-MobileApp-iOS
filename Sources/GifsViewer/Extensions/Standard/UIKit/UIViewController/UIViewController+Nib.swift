//
//  UIViewController+Nib.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 27.04.21.
//  Copyright © 2021 Arthur Tkachenko. All rights reserved.
//

import UIKit.UIViewController

extension UIViewController {
    
    static var identifier: String { String(describing: Self.self) }
    
    static func loadFromStoryboard(name: String? = nil) -> Self {
        let storyboard = UIStoryboard(name: name ?? identifier, bundle: nil)
        
        guard let viewController = storyboard
                .instantiateViewController(withIdentifier: identifier) as? Self else {
            fatalError("UIStoryboard: can not load ViewController with identifier '\(identifier)' from storyboard.")
        }
        return viewController
    }
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            T(nibName: identifier, bundle: nil)
        }
        
        return instantiateFromNib()
    }
}
