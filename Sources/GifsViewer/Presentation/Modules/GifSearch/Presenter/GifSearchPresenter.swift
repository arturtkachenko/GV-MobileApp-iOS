//
//  GifSearchPresenter.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/30/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import Foundation

// MARK: - Protocols

protocol GifSearchPresenterProtocol: PresenterProtocol {
    
    func presentRandomGif(_ model: GifItemModel)
    func presentGifSearchResults(_ model: GifSearchScreenModel)
    func presentGifDetailsModule(_ context: GifDetailsContext)
}

// MARK: - Implementation

final class GifSearchPresenter: BasePresenter {
    
    // MARK: - Properties
    
    private weak var view: GifSearchViewProtocol?
    
    // MARK: - Initializers
    
    init(router: Router, view: GifSearchViewProtocol?) {
        super.init(router: router)
        self.view = view
    }
}

// MARK: - GifSearchPresenterProtocol

extension GifSearchPresenter: GifSearchPresenterProtocol {
    
    func presentRandomGif(_ model: GifItemModel) {
        let viewModel = GifItemViewModel(model: model)
        view?.displayRandomGif(viewModel)
    }
    
    func presentGifSearchResults(_ model: GifSearchScreenModel) {
        let viewModels: [GifItemViewModel] = model.items.compactMap {
            GifItemViewModel(model: $0)
        }
        let screenViewModel = GifSearchScreenViewModel(items: viewModels, onSelectActionTriggered: model.onSelectActionTriggered)
        view?.displayGifSearchResults(screenViewModel)
    }
    
    func presentGifDetailsModule(_ context: GifDetailsContext) {
        router.push(GifDetailsAssembly.createModule(context))
    }
}
