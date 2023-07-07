//
//  ContentViewProtocol.swift
//  LowKeyTechChallenge
//
//  Created by Valery Garaev on 19.06.2023.
//

import UIKit

protocol ContentViewProtocol: UIView {
    associatedtype State
    associatedtype Output

    var state: State { get }
    var output: Output? { get set }
}
