//
//  PhotosListViewController.swift
//  LowKeyTechChallenge
//
//  Created by Valery Garaev on 19.06.2023.
//

import LowKeyClient
import Combine
import UIKit

final class PhotosListViewController<
    ContentView: ContentViewProtocol,
    Reducer: ReducerProtocol
>: UIViewController where Reducer.Action == PhotosListView.Action,
                          ContentView.State == Reducer.State,
                          ContentView.Output == PhotosListViewOutput {
    // MARK: Properties

    private let contentView: ContentView
    private let reducer: Reducer

    // MARK: - Lifecycle

    init(contentView: ContentView, reducer: Reducer) {
        self.contentView = contentView
        self.reducer = reducer

        super.init(nibName: nil, bundle: nil)

        self.contentView.output = self
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = L10n.CuratedPhotos.title

        reducer.reduce(
            state: contentView.state,
            action: .loadPhotos(isRefreshing: false)
        )
    }
}

// MARK: - PhotosListViewOutput

extension PhotosListViewController: PhotosListViewOutput {
    func loadNextPage(isPullToRefresh: Bool) {
        reducer.reduce(
            state: contentView.state,
            action: .loadPhotos(isRefreshing: isPullToRefresh)
        )
    }

    func didSelectPhoto(_ photo: Photo) {
        reducer.reduce(state: contentView.state, action: .displayPhotoDetails(photo))
    }
}
