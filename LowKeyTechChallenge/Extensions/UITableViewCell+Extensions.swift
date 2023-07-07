//
//  UITableViewCell+Extensions.swift
//  LowKeyTechChallenge
//
//  Created by Valery Garaev on 19.06.2023.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String { String(describing: Self.self) }
}
