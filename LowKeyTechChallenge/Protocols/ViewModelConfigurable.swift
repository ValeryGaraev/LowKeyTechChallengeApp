//
//  ViewModelConfigurable.swift
//  LowKeyTechChallenge
//
//  Created by Valery Garaev on 19.06.2023.
//

import UIKit

protocol ViewModelConfigurable: UIView {
    associatedtype ViewModel

    func configure(with viewModel: ViewModel)
}
