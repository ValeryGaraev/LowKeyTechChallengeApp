//
//  PhotosListCell.swift
//  LowKeyTechChallenge
//
//  Created by Valery Garaev on 19.06.2023.
//

import UIKit

final class PhotosListCell: UITableViewCell {
    // MARK: - Views

    private let innerContentView = {
        let innerContentView = UIView()
        innerContentView.layer.cornerRadius = Constants.cornerRadius
        innerContentView.layer.shadowColor = UIColor.lightGray.cgColor
        innerContentView.layer.shadowOffset = Constants.InnerContentView.shadowOffset
        innerContentView.layer.shadowOpacity = Constants.InnerContentView.shadowOpacity
        return innerContentView
    }()
    private let photographerNameLabel = UILabel()
    private let photoImageView = UIImageView()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [photoImageView, photographerNameLabel])
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.layer.cornerRadius = Constants.cornerRadius
        stackView.layer.masksToBounds = true
        stackView.spacing = Constants.StackView.spacing
        return stackView
    }()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        innerContentView.backgroundColor = .systemBackground

        addSubviews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        innerContentView.frame = contentView.bounds.inset(by: Constants.InnerContentView.insets)
        stackView.frame = innerContentView.bounds.inset(by: Constants.StackView.insets)

        innerContentView.layer.shadowPath = UIBezierPath(
            roundedRect: innerContentView.bounds,
            cornerRadius: Constants.cornerRadius
        ).cgPath
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        photoImageView.image = nil
        photographerNameLabel.text = nil
    }
}

// MARK: - Private

private extension PhotosListCell {
    enum Constants {
        static let cornerRadius: CGFloat = 16
        static let fontSize: CGFloat = 17

        enum InnerContentView {
            static let insets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
            static let shadowOffset = CGSize(width: 0.0, height: 0.5)
            static let shadowOpacity: Float = 1
        }

        enum PhotoImageView {
            static let height: CGFloat = 350
        }

        enum StackView {
            static let insets = UIEdgeInsets(top: .zero, left: .zero, bottom: 4, right: .zero)
            static let spacing: CGFloat = 4
        }
    }

    func addSubviews() {
        innerContentView.addSubview(stackView)
        contentView.addSubview(innerContentView)
    }
}

// MARK: - Static

extension PhotosListCell {
    static func height(with text: String, width: CGFloat) -> CGFloat {
        (text as NSString).boundingRect(
            with: CGSize(
                width: width
                - Constants.InnerContentView.insets.left
                - Constants.InnerContentView.insets.right,
                height: .infinity
            ),
            options: [.usesLineFragmentOrigin],
            attributes: [.font: UIFont.systemFont(ofSize: Constants.fontSize)],
            context: nil
        ).height
        + Constants.InnerContentView.insets.top
        + Constants.InnerContentView.insets.bottom
        + Constants.PhotoImageView.height
        + Constants.StackView.insets.top
        + Constants.StackView.insets.bottom
        + Constants.StackView.spacing
    }
}

// MARK: - ViewModelConfigurable

extension PhotosListCell: ViewModelConfigurable {
    struct ViewModel {
        let photo: UIImage?
        let photographerName: String
    }

    func configure(with viewModel: ViewModel) {
        photoImageView.image = viewModel.photo
        photographerNameLabel.text = viewModel.photographerName
    }
}
