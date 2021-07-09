//
//  Extension.swift
//  NewsFeed
//
//  Created by Karan Bhatt on 10/07/21.
//  Copyright © 2021 Anand Patel. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Date Extension

extension String {
    func  UTCToShortLocal() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: self) else {
            return ""
        }
        dateFormatter.dateFormat = "h:mm a"
        let dateString = dateFormatter.string(from: date)
        return dateString.lowercased()
    }
    func  UTCToLongLocal() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: self) else {
            return ""
        }
        dateFormatter.dateFormat = "E, d MMM yyyy h:mm a"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
