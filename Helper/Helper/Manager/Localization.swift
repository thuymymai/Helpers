//
//  Localization.swift
//  Helper
//
//  Created by Dang Son, My Mai, An Huynh on 29.4.2022.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}

