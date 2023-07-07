//
//  PhotosListView.swift
//  LowKeyTechChallenge
//
//  Created by Valery Garaev on 19.06.2023.
//

import Combine
import LowKeyClient
import UIKit

protocol PhotosListViewOutput: UIViewController {
    func loadNextPage(isPullToRefresh: Bool)
    func didSelectPhoto(_ photo: Photo)
}

final class PhotosListView: UIView, ContentViewProtocol {
    // MARK: - ContentViewProtocol

    let state: State
    weak var output: PhotosListViewOutput?

    // MARK: - Properties

    private var cancellables: Set<AnyCancellable> = []
    private let tableViewManager: ManagesPhotosTableView

    // MARK: - Views

    private lazy var tableView = {
        let tableView = PaginatedTableView()
        tableView.register(
            PhotosListCell.self,
            forCellReuseIdentifier: PhotosListCell.reuseIdentifier
        )
        tableView.delegate = tableViewManager
        tableView.dataSource = tableViewManager
        tableView.pagingDelegate = tableViewManager
        tableView.separatorStyle = .none
        return tableView
    }()

    // MARK: - Lifecycle

    init(state: State, tableViewManager: ManagesPhotosTableView) {
        self.state = state
        self.tableViewManager = tableViewManager

        super.init(frame: .zero)

        addSubviews()
        makeBindings()
    }

    override func layoutSubviews() {
        tableView.frame = bounds
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Cell

extension PhotosListView {
    enum Cell {
        case photo(Photo)
    }
}

// MARK: - Private

private extension PhotosListView {
    func addSubviews() {
        addSubview(tableView)
    }

    func makeBindings() {
        state.$cells
            .receive(on: DispatchQueue.main)
            .sink { [weak self] cells in
                guard let self else { return }

                tableViewManager.cells = cells
                tableView.reloadData()
            }
            .store(in: &cancellables)

        state.$isLoading
            .receive(on: DispatchQueue.main)
            .assign(to: \.isLoading, on: tableView)
            .store(in: &cancellables)
    }
}
