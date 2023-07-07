//
//  ViewModelProtocol.swift
//  LowKeyTechChallenge
//
//  Created by Valery Garaev on 22.06.2023.
//

import Foundation

protocol ReducerProtocol {
    associatedtype Action
    associatedtype State
    associatedtype Router

    func reduce(state: State, action: Action)

    var router: Router { get }
}
