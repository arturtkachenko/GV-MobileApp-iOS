//
//  GifDetailsAssembly.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/30/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import Foundation

final class GifDetailsAssembly: BaseAssembly<GifDetailsViewController> {
    
    override class func createModule(_ viewModel: GifItemViewModel? = nil) -> GifDetailsViewController {
        
        let view = Storyboards.gifDetails.controller as! GifDetailsViewController
        let router = Router(view: view)
        let presenter = GifDetailsPresenterImplementation(router: router, view: view)
        let interactor = GifDetailsInteractorImplementation(presenter: presenter, viewModel: viewModel)
        view.interactor = interactor
        
        return view
    }
}
