//
//  PhotoDetailsView.swift
//  LowKeyTechChallenge
//
//  Created by Valery Garaev on 06.07.2023.
//

import Combine
import UIKit

protocol PhotoDetailsViewOutput: UIViewController { }

final class PhotoDetailsView: UIView, ContentViewProtocol {
    typealias Output = PhotoDetailsViewOutput

    // MARK: - ContentViewProtocol

    let state: State
    weak var output: Output?

    // MARK: - Properties

    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Views

    private let photographerNameLabel = {
        let photographerNameLabel = UILabel()
        photographerNameLabel.numberOfLines = .zero
        photographerNameLabel.textAlignment = .center
        return photographerNameLabel
    }()
    private let photoImageView = {
        let photoImageView = UIImageView()
        photoImageView.contentMode = .scaleAspectFit
        return photoImageView
    }()

    // MARK: - Lifecycle

    init(state: State) {
        self.state = state

        super.init(frame: .zero)

        backgroundColor = .systemBackground

        addSubviews()
        makeBindings()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        photoImageView.frame.size.width = bounds.size.width
        photoImageView.frame.size.height = Constants.photoImageViewHeight

        photoImageView.frame.origin.y = safeAreaLayoutGuide.layoutFrame.midY
        - Constants.photoImageViewHeight / 2
        - Constants.photographerNameLabelSpacing
        - photographerNameLabel.intrinsicContentSize.height

        photographerNameLabel.frame.origin.y = photoImageView.frame.maxY + Constants.photographerNameLabelSpacing
        photographerNameLabel.frame.size.height = photographerNameLabel.intrinsicContentSize.height
        photographerNameLabel.frame.size.width = bounds.width
    }
}

// MARK: - Private

private extension PhotoDetailsView {
    enum Constants {
        static let photoImageViewHeight: CGFloat = 350
        static let photographerNameLabelSpacing: CGFloat = 8
    }

    func addSubviews() {
        [photographerNameLabel, photoImageView].forEach(addSubview(_:))
    }

    func makeBindings() {
        state.$photo
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: photoImageView)
            .store(in: &cancellables)

        state.$photographerName
            .assign(to: \.text, on: photographerNameLabel)
            .store(in: &cancellables)
    }
}
