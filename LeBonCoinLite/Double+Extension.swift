//
//  Double+Extension.swift
//  LeBonCoinLite
//
//  Created by Alexandre Guzu on 23/09/2021.
//

import Foundation

extension Double {
    func formatToPrice() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.numberStyle = .currency
        if let formattedPrice = formatter.string(from: self as NSNumber) {
            return formattedPrice
        }
        return "- €"
    }
}
