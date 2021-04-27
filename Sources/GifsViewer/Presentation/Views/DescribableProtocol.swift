//
//  DescribableProtocol.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/30/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import UIKit

protocol IndentifierDescribeProtocol {
    static var identifier: String { get }
}

extension IndentifierDescribeProtocol {
    static var identifier: String { return .init(describing: self) }
}

protocol DescribableProtocol: IndentifierDescribeProtocol {

    associatedtype SelfType
    
    static var nib: UINib? { get }
    static var viewFromNib: SelfType? { get }
}

extension DescribableProtocol {

    static var nib: UINib? {
        
        let identifier = self.identifier
        guard Bundle.main.path(forResource: identifier, ofType: "nib") != nil else {
            return nil
        }
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var viewFromNib: Self? {
        return nib?.instantiate(withOwner: self,
                                options: nil).first as? Self
    }
}
