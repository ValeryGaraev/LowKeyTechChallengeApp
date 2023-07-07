//
//  PhotosListViewAction.swift
//  LowKeyTechChallenge
//
//  Created by Valery Garaev on 19.06.2023.
//

import Foundation
import LowKeyClient

extension PhotosListView {
    enum Action {
        case loadPhotos(isRefreshing: Bool)
        case displayPhotoDetails(Photo)
    }
}
