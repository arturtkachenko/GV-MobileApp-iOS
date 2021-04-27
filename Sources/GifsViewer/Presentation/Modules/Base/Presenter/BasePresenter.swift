//
//  BasePresenter.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/30/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import Foundation

protocol PresenterProtocol {}

class BasePresenter {
    
    let router: Router
    
    init(router: Router) {
        self.router = router
    }
}

extension BasePresenter: PresenterProtocol {}
