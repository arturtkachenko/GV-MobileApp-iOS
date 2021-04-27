//
//  GifDetailsViewController.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/30/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import UIKit

// MARK: - Protocols

protocol GifDetailsViewProtocol: ViewProtocol {
    func displayGifDetails(_ viewModel: GifItemViewModel)
}

// MARK: - Implementation

final class GifDetailsViewController: BaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var gifImageView: UIImageView!
    @IBOutlet private weak var ageRestrictionImageView: UIImageView!
    @IBOutlet private weak var gifTitleLabel: UILabel!
    @IBOutlet private weak var gifLinkLabel: UILabel!
    
    var interactor: GifDetailsInteractor?
    
    // MARK: - Lifecycle
    
    override func setupInterface() {
        super.setupInterface()
        interactor?.fetchGifDetails()
    }
}

// MARK: - GifDetailsViewProtocol

extension GifDetailsViewController: GifDetailsViewProtocol {
    
    func displayGifDetails(_ viewModel: GifItemViewModel) {
        bind(viewModel: viewModel)
    }
}

// MARK: - ViewModelBindableProtocol

extension GifDetailsViewController: ViewModelBindableProtocol {
    
    typealias ViewModel = GifItemViewModel
    
    func bind(viewModel: GifItemViewModel) {
        guard let gifUrl = URL(string: viewModel.gifUrl) else { return }
        gifImageView.setGif(from: gifUrl)
        
        let ageRestrictionImage = UIImage(named: "\(viewModel.gifAgeRestriction)_badge")
        ageRestrictionImageView.image = ageRestrictionImage
        
        title = viewModel.gifTitle
        gifTitleLabel.text = viewModel.gifTitle
        gifLinkLabel.text = viewModel.gifUrl
    }
}
