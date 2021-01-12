//
//  GIF.swift
//  Giphy
//
//  Created by 현진 on 2021/01/10.
//

import Foundation

struct GIF: Codable {
    
    let id: String
    let url: String
    let slug: String
    let username, source, title, rating: String
    let importDatetime, trendingDatetime: String
    let images: Images
    let user: User?

    enum CodingKeys: String, CodingKey {
        case id, url, slug
        case username, source, title, rating
        case importDatetime = "import_datetime"
        case trendingDatetime = "trending_datetime"
        case images, user
    }
    
    struct Images: Codable {
        let fixedHeightSmall: Image
        
        enum CodingKeys: String, CodingKey {
            case fixedHeightSmall = "fixed_height_small"
        }
        
        struct Image: Codable {
            let height, width, size: String
            let mp4: String
        }
        
    }
    
}
