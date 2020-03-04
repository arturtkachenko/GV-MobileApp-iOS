//
//  GifDetailsViewController.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/30/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import UIKit

protocol GifDetailsView: View {
    func displayGifDetails(_ viewModel: GifItemViewModel)
}

final class GifDetailsViewController: BaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var gifImageView: UIImageView!
    @IBOutlet private weak var ageRestrictionImageView: UIImageView!
    @IBOutlet private weak var gifTitleLabel: UILabel!
    @IBOutlet private weak var gifLinkLabel: UILabel!
    
    var interactor: GifDetailsInteractor?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchGifDetails()
    }
}

extension GifDetailsViewController: GifDetailsView {
    
    func displayGifDetails(_ viewModel: GifItemViewModel) {
        bind(viewModel: viewModel)
    }
}

extension GifDetailsViewController: ViewModelBindable {
    
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
