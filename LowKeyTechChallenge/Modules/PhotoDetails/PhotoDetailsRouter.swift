//
//  PhotoDetailsRouter.swift
//  LowKeyTechChallenge
//
//  Created by Valery Garaev on 06.07.2023.
//

import UIKit

final class PhotoDetailsRouter: RouterProtocol {
    // MARK: - RouterProtocol

    weak var viewController: UIViewController?

    func navigate(to path: Path) { }
}

// MARK: - Path

extension PhotoDetailsRouter {
    enum Path { }
}
