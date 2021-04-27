//
//  GifSearchViewController.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/30/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import UIKit

// MARK: - Protocols

protocol GifSearchViewProtocol: ViewProtocol {
    
    func displayRandomGif(_ viewModel: GifItemViewModel)
    func displayGifSearchResults(_ viewModel: GifSearchScreenViewModel)
}

// MARK: - Implementation

final class GifSearchViewController: BaseViewController {
    
    // MARK: - Constants
    
    private enum Layout {
        
        enum CollectionView {
            
            static let edgeInsets = UIEdgeInsets(top: .zero,
                                                 left: 16.0,
                                                 bottom: .zero,
                                                 right: 16.0)
            
            enum Space {
                
                static let betweenItems: CGFloat = 8.0
            }
        }
    }
    
    // MARK: - Properties
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var gifInfoStackView: UIStackView!
    
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var gifTitleLabel: UILabel!
    @IBOutlet private weak var gifLinkLabel: UILabel!
    
    @IBOutlet private weak var randomGifImageView: UIImageView!
    @IBOutlet private weak var ageRestrictionImageView: UIImageView!
    
    var interactor: GifSearchInteractorProtocol?
    private var viewModel: GifSearchScreenViewModel?
    
    // MARK: - Lifecycle
    
    override func setupInterface() {
        super.setupInterface()
        setupCollectionView()
        setupSearchBar()
        configureAppearance(searchStarted: false)
        
        interactor?.startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchBar.endEditing(true)
    }
    
    // MARK: - Setup
    
    private func setupCollectionView() {
        collectionView.register(GifCollectionViewCell.nib,
                                forCellWithReuseIdentifier: GifCollectionViewCell.identifier)
        collectionView.contentInset = Layout.CollectionView.edgeInsets
        collectionView.isHidden = true
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
    }
    
    // MARK: - General
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func configureAppearance(searchStarted: Bool) {
        collectionView.isHidden = !searchStarted
        randomGifImageView.isHidden = searchStarted
        gifInfoStackView.isHidden = searchStarted
        statusLabel.text = searchStarted ? "Search results:" : "Random selected GIF:"
    }
    
    private func resetSearchBar() {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
    
    private func resetCollectionView() {
        viewModel = nil
        collectionView.reloadData()
    }
}

// MARK: - GifSearchViewProtocol

extension GifSearchViewController: GifSearchViewProtocol {
    
    
    func displayRandomGif(_ viewModel: GifItemViewModel) {
        bind(viewModel: viewModel)
    }
    
    func displayGifSearchResults(_ viewModel: GifSearchScreenViewModel) {
        self.viewModel = viewModel
        collectionView.reloadData()
    }
}

// MARK: - ViewModelBindableProtocol

extension GifSearchViewController: ViewModelBindableProtocol {
    
    typealias ViewModel = GifItemViewModel
    
    func bind(viewModel: GifItemViewModel) {
        
        guard let gifUrl = URL(string: viewModel.gifUrl) else { return }
        randomGifImageView.setGif(from: gifUrl)
        
        let ageRestrictionImage = UIImage(named: "\(viewModel.gifAgeRestriction)_badge")
        ageRestrictionImageView.image = ageRestrictionImage
        
        gifTitleLabel.text = viewModel.gifTitle
        gifLinkLabel.text = viewModel.gifUrl
    }
}

// MARK: - UISearchBarDelegate

extension GifSearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            resetCollectionView()
            return
        }
        interactor?.fetchGifs(by: searchText)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        configureAppearance(searchStarted: true)
        interactor?.endTimer()
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resetSearchBar()
        resetCollectionView()
        configureAppearance(searchStarted: false)
        interactor?.startTimer()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

// MARK: - UICollectionViewDataSource

extension GifSearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.items.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = viewModel?.items[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GifCollectionViewCell.identifier, for: indexPath)
        (cell as? GifCollectionViewCell)?.bind(viewModel: item)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension GifSearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.onSelectActionTriggered(indexPath.row)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GifSearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        GifCollectionViewCell.estimatedSize(from: collectionView.bounds.size)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        Layout.CollectionView.Space.betweenItems
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Layout.CollectionView.Space.betweenItems
    }
}
