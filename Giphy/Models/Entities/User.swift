//
//  User.swift
//  Giphy
//
//  Created by 현진 on 2021/01/10.
//

import Foundation

struct User: Codable {
    let avatarURL, bannerImage, bannerURL: String?
    let profileURL: String?
    let username, displayName, userDescription: String
    let instagramURL: String?
    let websiteURL: String?
    let isVerified: Bool

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case bannerImage = "banner_image"
        case bannerURL = "banner_url"
        case profileURL = "profile_url"
        case username
        case displayName = "display_name"
        case userDescription = "description"
        case instagramURL = "instagram_url"
        case websiteURL = "website_url"
        case isVerified = "is_verified"
    }
}
