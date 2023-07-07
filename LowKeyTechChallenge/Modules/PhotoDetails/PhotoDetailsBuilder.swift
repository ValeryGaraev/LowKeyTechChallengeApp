//
//  PhotoDetailsBuilder.swift
//  LowKeyTechChallenge
//
//  Created by Valery Garaev on 06.07.2023.
//

import LowKeyClient
import UIKit

final class PhotoDetailsBuilder: BuilderProtocol {
    // MARK: - Properties

    private let photo: Photo

    // MARK: - Lifecycle

    init(photo: Photo) {
        self.photo = photo
    }

    // MARK: - BuilderProtocol

    func build() -> UIViewController {
        let router = PhotoDetailsRouter()
        let reducer = PhotoDetailsReducer(router: router)
        let contentView = PhotoDetailsView(state: PhotoDetailsView.State(photoDto: photo))
        let viewController = PhotoDetailsViewController(contentView: contentView, reducer: reducer)
        contentView.output = viewController
        router.viewController = viewController

        return viewController
    }
}
