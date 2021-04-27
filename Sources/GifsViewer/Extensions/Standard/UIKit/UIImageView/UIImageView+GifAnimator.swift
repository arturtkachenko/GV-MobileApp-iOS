//
//  UIImageView+GifAnimator.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 2/1/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import SwiftyGif

extension UIImageView {
    
    func setGif(from url: URL) {
        self.setGifFromURL(url)
    }
}
