//
//  GifSearchViewController.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/30/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import UIKit

protocol GifSearchView: View {
    
    func displayRandomGif(_ viewModel: GifItemViewModel)
    func displayGifSearchResults(_ viewModels: [GifItemViewModel])
}

final class GifSearchViewController: BaseViewController {
    
    // MARK: - Constants
    
    private enum Layout {
        static let collectionEdgeInsets = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        
        enum Space {
            static let betweenItems: CGFloat = 8.0
        }
    }
    
    // MARK: - Properties
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var gifInfoStackView: UIStackView!
    @IBOutlet private weak var gifTitleLabel: UILabel!
    @IBOutlet private weak var gifLinkLabel: UILabel!
    @IBOutlet private weak var randomGifImageView: UIImageView!
    @IBOutlet private weak var ageRestrictionImageView: UIImageView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var interactor: GifSearchInteractor?
    private var searchResultsViewModels: [GifItemViewModel]?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchBar.endEditing(true)
    }
    
    // MARK: - Setup
    
    override func setupInterface() {
        super.setupInterface()
        setupNavigationBar()
        setupCollectionView()
        setupSearchBar()
        configureAppearance(searchStarted: false)
    }
    
    private func setupNavigationBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
    }
    
    private func setupCollectionView() {
        collectionView.register(GifCollectionViewCell.nib,
                                forCellWithReuseIdentifier: GifCollectionViewCell.identifier)
        collectionView.contentInset = Layout.collectionEdgeInsets
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
        searchResultsViewModels = nil
        collectionView.reloadData()
    }
}

extension GifSearchViewController: GifSearchView {
    
    
    func displayRandomGif(_ viewModel: GifItemViewModel) {
        bind(viewModel: viewModel)
    }
    
    func displayGifSearchResults(_ viewModels: [GifItemViewModel]) {
        searchResultsViewModels = viewModels
        collectionView.reloadData()
    }
}

extension GifSearchViewController: ViewModelBindable {
    
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
        return searchResultsViewModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = searchResultsViewModels?[safe: indexPath.row] else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GifCollectionViewCell.identifier, for: indexPath)
        (cell as? GifCollectionViewCell)?.bind(viewModel: item)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension GifSearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedViewModel = searchResultsViewModels?[safe: indexPath.row] else { return }
        interactor?.openGifDetailsModule(selectedViewModel)
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
        return GifCollectionViewCell.estimatedSize(from: collectionView.bounds.size)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Layout.Space.betweenItems
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Layout.Space.betweenItems
    }
}
