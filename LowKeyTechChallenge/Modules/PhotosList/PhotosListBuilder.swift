//
//  PhotosListBuilder.swift
//  LowKeyTechChallenge
//
//  Created by Valery Garaev on 22.06.2023.
//

import UIKit

final class PhotosListBuilder: BuilderProtocol {
    func build() -> UIViewController {
        let router = PhotosListRouter()
        let tableViewManager: ManagesPhotosTableView = PhotosTableViewManager()
        let contentView = PhotosListView(
            state: PhotosListView.State(),
            tableViewManager: tableViewManager
        )
        let viewController = PhotosListViewController(
            contentView: contentView,
            reducer: PhotosListReducer(router: router)
        )
        contentView.output = viewController
        router.viewController = viewController
        tableViewManager.output = viewController

        return viewController
    }
}
