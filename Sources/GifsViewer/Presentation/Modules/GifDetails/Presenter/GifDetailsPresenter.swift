//
//  GifDetailsPresenter.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/30/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import Foundation

// MARK: - Protocols

protocol GifDetailsPresenterProtocol: PresenterProtocol {
    func presentGifDetails(_ model: GifItemModel)
}

// MARK: - Implementation

final class GifDetailsPresenter: BasePresenter {
    
    // MARK: - Properties
    
    private weak var view: GifDetailsViewProtocol?
    
    // MARK: - Initializers
    
    init(router: Router, view: GifDetailsViewProtocol?) {
        super.init(router: router)
        self.view = view
    }
}

// MARK: - GifDetailsPresenterProtocol

extension GifDetailsPresenter: GifDetailsPresenterProtocol {
    
    func presentGifDetails(_ model: GifItemModel) {
        let viewModel = GifItemViewModel(model: model)
        view?.displayGifDetails(viewModel)
    }
}
