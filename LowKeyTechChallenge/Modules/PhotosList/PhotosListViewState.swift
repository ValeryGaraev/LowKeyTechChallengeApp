//
//  PhotosListViewState.swift
//  LowKeyTechChallenge
//
//  Created by Valery Garaev on 19.06.2023.
//

import Foundation

extension PhotosListView {
    final class State {
        @Published var cells: [PhotosListView.Cell] = []
        @Published var isLoading = false

        var currentPage: Int = .zero
    }
}
