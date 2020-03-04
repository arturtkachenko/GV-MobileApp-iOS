//
//  GifDetailsPresenter.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/30/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import Foundation

protocol GifDetailsPresenter: Presenter {
    func presentGifDetails(_ viewModel: GifItemViewModel)
}

final class GifDetailsPresenterImplementation: BasePresenter {
    
    private weak var view: GifDetailsView?
    
    init(router: Router, view: GifDetailsView?) {
        super.init(router: router)
        self.view = view
    }
}

extension GifDetailsPresenterImplementation: GifDetailsPresenter {
    
    func presentGifDetails(_ viewModel: GifItemViewModel) {
        view?.displayGifDetails(viewModel)
    }
}
