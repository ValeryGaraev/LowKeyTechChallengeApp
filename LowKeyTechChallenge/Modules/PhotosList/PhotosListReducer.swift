//
//  PhotosListReducer.swift
//  LowKeyTechChallenge
//
//  Created by Valery Garaev on 22.06.2023.
//

import Foundation
import LowKeyClient

final class PhotosListReducer<Router: RouterProtocol> where Router.Path ==  PhotosListRouter.Path {
    typealias Action = PhotosListView.Action
    typealias State = PhotosListView.State

    // MARK: - Properties

    let router: Router

    // MARK: - Lifecycle

    init(router: Router) {
        self.router = router
    }
}

// MARK: - ReducerProtocol

extension PhotosListReducer: ReducerProtocol {
    func reduce(state: State, action: Action) {
        switch action {
        case let .loadPhotos(isRefreshing):
            state.currentPage = isRefreshing ? 1 : (state.currentPage + 1)

            Task {
                state.isLoading.toggle()

                let cells = await loadPhotos(page: state.currentPage)

                if isRefreshing {
                    state.cells = cells
                } else {
                    state.cells += cells
                }

                state.isLoading.toggle()
            }
        case let .displayPhotoDetails(photo):
            router.navigate(to: .photoDetails(photo))
        }
    }
}

// MARK: - Private

private extension PhotosListReducer {
    func loadPhotos(page: Int) async -> [PhotosListView.Cell] {
        guard
            let photos = try? await PhotosAPI
                .getCuratedPhotos(page: page, perPage: 15)
                .photos
        else { return [] }

        return photos.map { .photo($0) }
    }
}
