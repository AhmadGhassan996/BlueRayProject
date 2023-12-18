//
//  Extension+String.swift
//  Blue Ray Project
//
//  Created by AhmadSulaiman on 18/12/2023.
//

import Foundation
extension String {
    func htmlToAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: .utf8) else { return nil }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        do {
            return try NSAttributedString(data: data, options: options, documentAttributes: nil)
        } catch {
            print("Error converting HTML string to NSAttributedString: \(error)")
            return nil
        }
    }
}
