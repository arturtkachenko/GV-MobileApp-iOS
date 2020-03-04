//
//  GifCollectionViewCell.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/30/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import UIKit

final class GifCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    private enum Layout {
        
        enum Space {
            static let left: CGFloat = 8.0
            static let right: CGFloat = 8.0
        }
    }
    
    // MARK: - Properties

    @IBOutlet private weak var gifImageView: UIImageView!
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gifImageView.image = nil
    }
}

extension GifCollectionViewCell: ViewModelBindable {
    
    typealias ViewModel = GifItemViewModel
    
    func bind(viewModel: GifItemViewModel) {
        guard let gifImageUrl = URL(string: viewModel.gifImageUrl) else { return }
        gifImageView.setGif(from: gifImageUrl)
    }
}

extension GifCollectionViewCell: SizeCalculatable {
    
    static func estimatedSize(from containerSize: CGSize) -> CGSize {
        let width = containerSize.width / 3.0 - (Layout.Space.left + Layout.Space.right)
        let height = width
        return CGSize(width: width, height: height)
    }
}
