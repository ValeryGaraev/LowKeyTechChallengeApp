//
//  PhotosTableViewManager.swift
//  LowKeyTechChallenge
//
//  Created by Valery Garaev on 21.06.2023.
//

import UIKit

protocol ManagesPhotosTableView: UITableViewDelegate, UITableViewDataSource, PaginatedTableViewDelegate {
    var cells: [PhotosListView.Cell] { get set }
    var output: PhotosListViewOutput? { get set }
}

final class PhotosTableViewManager: NSObject, ManagesPhotosTableView {
    var cells: [PhotosListView.Cell] = []
    weak var output: PhotosListViewOutput?
}

// MARK: - UITableViewDataSource

extension PhotosTableViewManager {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cells[indexPath.row] {
        case let .photo(photo):
            return PhotosListCell.height(
                with: photo.photographer ?? .empty,
                width: UIScreen.main.bounds.width
            )
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cells[indexPath.row] {
        case .photo(let photo):
            let photoCell = tableView.dequeueReusableCell(
                withIdentifier: PhotosListCell.reuseIdentifier,
                for: indexPath
            ) as? PhotosListCell

            Task {
                guard
                    let urlString = photo.src?.medium,
                    let url = URL(string: urlString)
                else { return }

                await photoCell?.configure(
                    with: PhotosListCell.ViewModel(
                        photo: try? PhotoLoader.shared.loadPhoto(from: url),
                        photographerName: photo.photographer ?? .empty
                    )
                )
            }

            return photoCell ?? UITableViewCell()
        }
    }
}

// MARK: - UITableViewDataSource

extension PhotosTableViewManager {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case let .photo(photo):
            output?.didSelectPhoto(photo)
        }
    }
}

// MARK: - PaginatedTableViewDelegate

extension PhotosTableViewManager {
    func loadNextPage(isPullToRefresh: Bool) {
        output?.loadNextPage(isPullToRefresh: isPullToRefresh)
    }
}
