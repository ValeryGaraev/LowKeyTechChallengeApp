//
//  PaginatedTableView.swift
//  LowKeyTechChallenge
//
//  Created by Valery Garaev on 05.07.2023.
//

import Combine
import UIKit

protocol PaginatedTableViewDelegate: AnyObject {
    func loadNextPage(isPullToRefresh: Bool)
}

final class PaginatedTableView: UITableView {
    // MARK: - Properties

    var isLoading: Bool = false {
        didSet {
            if !isLoading {
                refreshControl?.endRefreshing()
            }
        }
    }

    weak var pagingDelegate: PaginatedTableViewDelegate?

    private var previousItemCount: Int = .zero

    // MARK: - Lifecycle

    init() {
        super.init(frame: .zero, style: .plain)

        configureRefreshControl()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Selectors

    @objc
    private func pullToRefreshAction() {
        refreshControl?.beginRefreshing()
        pagingDelegate?.loadNextPage(isPullToRefresh: true)
    }
}

// MARK: - Override

extension PaginatedTableView {
    override func dequeueReusableCell(
        withIdentifier identifier: String,
        for indexPath: IndexPath
    ) -> UITableViewCell {
        paginate(self, for: indexPath)
        return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
}

// MARK: - Private

private extension PaginatedTableView {
    func configureRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self,
            action: #selector(pullToRefreshAction),
            for: .valueChanged
        )
        self.refreshControl = refreshControl
    }

    func paginate(_ tableView: PaginatedTableView, for indexPath: IndexPath) {
        guard !isLoading else { return }

        var itemCount = Int.zero
        let lastSectionIndex = tableView.numberOfSections - 1

        for section in .zero...lastSectionIndex {
            itemCount += tableView.dataSource?.tableView(tableView, numberOfRowsInSection: section) ?? .zero
        }

        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1

        guard
            indexPath.row == lastRowIndex,
            indexPath.section == tableView.numberOfSections - 1,
            previousItemCount != itemCount
        else { return }

        previousItemCount = itemCount
        pagingDelegate?.loadNextPage(isPullToRefresh: false)
    }
}
