//
//  PhotoDetailsViewController.swift
//  LowKeyTechChallenge
//
//  Created by Valery Garaev on 06.07.2023.
//

import UIKit

final class PhotoDetailsViewController<
    ContentView: ContentViewProtocol,
    Reducer: ReducerProtocol
>: UIViewController where Reducer.Action == PhotoDetailsView.Action,
                          Reducer.State == ContentView.State,
                          ContentView.Output == PhotoDetailsViewOutput {
    // MARK: Properties

    private let contentView: ContentView
    private let reducer: Reducer

    // MARK: - Lifecycle

    init(contentView: ContentView, reducer: Reducer) {
        self.contentView = contentView
        self.reducer = reducer

        super.init(nibName: nil, bundle: nil)
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

        reducer.reduce(state: contentView.state, action: .displayPhoto)
    }
}

// MARK: - PhotoDetailsViewOutput

extension PhotoDetailsViewController: PhotoDetailsViewOutput { }
