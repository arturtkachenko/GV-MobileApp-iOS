//
//  GifSearchPresenter.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/30/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import Foundation

protocol GifSearchPresenter: Presenter {
    
    func presentGifDetailsModule(_ viewModel: GifItemViewModel)
    func presentRandomGif(_ model: GifItemModel)
    func presentGifSearchResults(_ models: [GifItemModel])
}

final class GifSearchPresenterImplementation: BasePresenter {
    
    private weak var view: GifSearchView?
    
    init(router: Router, view: GifSearchView?) {
        super.init(router: router)
        self.view = view
    }
}

extension GifSearchPresenterImplementation: GifSearchPresenter {
    
    func presentRandomGif(_ model: GifItemModel) {
        let viewModel: GifItemViewModel = GifItemViewModel(model)
        DispatchQueue.main.async {
            self.view?.displayRandomGif(viewModel)
        }
    }
    
    func presentGifSearchResults(_ models: [GifItemModel]) {
        let viewModels: [GifItemViewModel] = models.compactMap {
            GifItemViewModel($0)
        }
        DispatchQueue.main.async {
            self.view?.displayGifSearchResults(viewModels)
        }
    }
    
    func presentGifDetailsModule(_ viewModel: GifItemViewModel) {
        router.push(GifDetailsAssembly.createModule(viewModel))
    }
}
