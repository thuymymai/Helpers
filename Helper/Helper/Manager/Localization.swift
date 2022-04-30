//
//  Localization.swift
//  Helper
//
//  Created by Dang Son on 29.4.2022.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}

