//
//  RadiatorModel.swift
//  Blue Ray Project
//
//  Created by AhmadSulaiman on 18/12/2023.
//

import Foundation
struct RadiatorModel: Codable {
    let msg: Msg
    let data: [ItemData]
}
// MARK: - ItemData
struct ItemData: Codable {
    let title, body: String
    let coverImage: String
    let images: [Image]
    enum CodingKeys: String, CodingKey {
        case title, body
        case coverImage = "cover_Image"
        case images = "Images"
    }
}
// MARK: - Image
struct Image: Codable {
    let imgLink: String
    enum CodingKeys: String, CodingKey {
        case imgLink = "img_link"
    }
}

// MARK: - Msg
struct Msg: Codable {
    let status: Int
    let message: String
}
