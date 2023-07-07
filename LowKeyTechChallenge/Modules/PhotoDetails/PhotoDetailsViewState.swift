//
//  PhotosDetailsViewModel.swift
//  LowKeyTechChallenge
//
//  Created by Valery Garaev on 06.07.2023.
//

import Foundation
import LowKeyClient
import UIKit

extension PhotoDetailsView {
    final class State {
        // MARK: - @Published

        @Published var photo: UIImage?
        @Published var photographerName: String?

        // MARK: - Properties

        let photoDto: Photo

        // MARK: - Lifecycle

        init(photoDto: Photo) {
            self.photoDto = photoDto
        }
    }

}
