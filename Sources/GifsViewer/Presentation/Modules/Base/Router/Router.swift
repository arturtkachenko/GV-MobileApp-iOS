//
//  Router.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/30/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import UIKit

class Router {
    
    private(set) weak var view: UIViewController?

    init(view: UIViewController) {
        self.view = view
    }
}

// MARK: - Push / Pop presentation

extension Router {
    
    func push(_ destinationView: UIViewController) {
        view?.navigationController?.pushViewController(destinationView,
                                                       animated: true)
    }
    
    func pop(to destinationView: UIViewController) {
        view?.navigationController?.popToViewController(destinationView,
                                                        animated: true)
    }
    
    func pop() {
        view?.navigationController?.popViewController(animated: true)
    }
}

// MARK: - View transitions

extension Router {
    
    func transitTo(_ view: UIViewController, embeddedFromNavigation: Bool = false) {
        guard
            let window = UIApplication.shared.delegate?.window!,
            let rootViewController = window.rootViewController
        else {
            return
        }
        
        let view = embeddedFromNavigation ? UINavigationController(rootViewController: view) : view
        
        if let presentingViewController = self.view?.presentingViewController {
            presentingViewController.dismiss(animated: false, completion: nil)
        } else if self.view?.presentedViewController != nil {
            self.view?.dismiss(animated: false, completion: nil)
        }
        
        rootViewController.dismiss(animated: false, completion: nil)
        window.rootViewController = view
    }
}
