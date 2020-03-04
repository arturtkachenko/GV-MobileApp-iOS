//
//  GifSearchAssembly.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/30/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import Foundation

final class GifSearchAssembly: BaseAssembly<GifSearchViewController> {
    
    override class func createModule(_ viewModel: GifItemViewModel? = nil) -> GifSearchViewController {
        
        let view = Storyboards.gifSearch.controller as! GifSearchViewController
        let router = Router(view: view)
        let presenter = GifSearchPresenterImplementation(router: router, view: view)
        let interactor = GifSearchInteractorImplementation(presenter: presenter, gifBackendService: GifBackendServiceImplementation())
        view.interactor = interactor
        
        return view
    }
}
