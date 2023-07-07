//
//  PhotoLoader.swift
//  LowKeyTechChallenge
//
//  Created by Valery Garaev on 22.06.2023.
//

import UIKit

final class PhotoLoader {
    static let shared = PhotoLoader()

    private init() { }

    private let photoCache = NSCache<NSString, UIImage>()

    func loadPhoto(from url: URL) async throws -> UIImage {
        if let cachedPhoto = photoCache.object(forKey: url.absoluteString as NSString) {
            return cachedPhoto
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        guard let downloadedPhoto = UIImage(data: data) else {
            throw PhotoLoadingError.invalidData
        }

        photoCache.setObject(downloadedPhoto, forKey: url.absoluteString as NSString)

        return downloadedPhoto
    }
}

private extension PhotoLoader {
    enum PhotoLoadingError: Error {
        case invalidData
    }
}
