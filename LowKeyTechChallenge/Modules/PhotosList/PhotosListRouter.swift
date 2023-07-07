//
//  PhotosListRouter.swift
//  LowKeyTechChallenge
//
//  Created by Valery Garaev on 06.07.2023.
//

import LowKeyClient
import UIKit

final class PhotosListRouter: RouterProtocol {
    // MARK: - RouterProtocol

    weak var viewController: UIViewController?

    func navigate(to path: Path) {
        switch path {
        case let .photoDetails(photo):
            let builder = PhotoDetailsBuilder(photo: photo)

            viewController?.navigationController?.pushViewController(
                builder.build(),
                animated: true
            )
        }
    }
}

// MARK: - Path

extension PhotosListRouter {
    enum Path {
        case photoDetails(Photo)
    }
}
