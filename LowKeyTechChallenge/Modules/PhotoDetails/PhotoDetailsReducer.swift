//
//  PhotoDetailsReducer.swift
//  LowKeyTechChallenge
//
//  Created by Valery Garaev on 06.07.2023.
//

import Foundation
import LowKeyClient

final class PhotoDetailsReducer<Router: RouterProtocol>: ReducerProtocol where Router.Path ==  PhotoDetailsRouter.Path {
    typealias Action = PhotoDetailsView.Action
    typealias State = PhotoDetailsView.State

    let router: Router

    init(router: Router) {
        self.router = router
    }

    func reduce(state: State, action: Action) {
        switch action {
        case .displayPhoto:
            let photo = state.photoDto

            Task {
                guard
                    let urlString = photo.src?.medium,
                    let url = URL(string: urlString),
                    let photo = try? await PhotoLoader.shared.loadPhoto(from: url)
                else { return }

                state.photo = photo
            }

            state.photographerName = photo.photographer
        }
    }
}
