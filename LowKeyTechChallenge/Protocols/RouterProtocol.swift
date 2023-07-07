//
//  RouterProtocol.swift
//  LowKeyTechChallenge
//
//  Created by Valery Garaev on 06.07.2023.
//

import UIKit

protocol RouterProtocol {
    associatedtype Path

    var viewController: UIViewController? { get set }

    func navigate(to path: Path)
}
