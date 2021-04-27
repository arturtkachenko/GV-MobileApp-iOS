//
//  GifSearchAssembly.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/30/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import Foundation

final class GifSearchAssembly: BaseAssembly<GifSearchViewController> {
    
    override class func createModule(_ context: ContextProtocol? = nil) -> GifSearchViewController {
        super.createModule(context)
        
        let view = GifSearchViewController.loadFromStoryboard()
        let router = Router(view: view)
        let presenter = GifSearchPresenter(router: router, view: view)
        let interactor = GifSearchInteractor(presenter: presenter, gifBackendService: GifBackendService())
        view.interactor = interactor
        
        return view
    }
}
