//
//  GifDetailsAssembly.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/30/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import Foundation

final class GifDetailsAssembly: BaseAssembly<GifDetailsViewController> {
    
    override class func createModule(_ context: ContextProtocol? = nil) -> GifDetailsViewController {
        super.createModule(context)
        
        let view = GifDetailsViewController.loadFromStoryboard()
        let router = Router(view: view)
        let presenter = GifDetailsPresenter(router: router, view: view)
        let interactor = GifDetailsInteractor(presenter: presenter, context: context as? GifDetailsContext)
        view.interactor = interactor
        
        return view
    }
}
