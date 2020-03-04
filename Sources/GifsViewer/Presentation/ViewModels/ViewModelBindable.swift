//
//  ViewModelBindable.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/31/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import Foundation

protocol ViewModelBindable {
    
    associatedtype ViewModel
    
    func bind(viewModel: ViewModel)
}
