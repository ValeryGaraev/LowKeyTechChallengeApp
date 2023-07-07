//
//  AppDelegate.swift
//  LowKeyTechChallenge
//
//  Created by Valery Garaev on 19.06.2023.
//

import UIKit
import LowKeyClient

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        setApiKey()

        window = UIWindow(frame: UIScreen.main.bounds)

        let navigationController = UINavigationController(rootViewController: PhotosListBuilder().build())

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }

    private func setApiKey() {
        if let infoPlistPath = Bundle.main.url(forResource: "Info", withExtension: "plist") {
            do {
                let infoPlistData = try Data(contentsOf: infoPlistPath)

                if
                    let dictionary = try PropertyListSerialization.propertyList(
                        from: infoPlistData,
                        options: [],
                        format: nil
                    ) as? [String: Any],
                    let apiKey = dictionary["ApiKey"] as? String
                { LowKeyClientAPI.customHeaders["Authorization"] = apiKey }
            } catch {
                print(error)
            }
        }
    }
}
