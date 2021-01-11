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
    let user: User

    struct Images: Codable {
        let fixedHeightSmall: Image
        
        struct Image: Codable {
            let height, width, size: String
            let mp4: String
        }
    }
    
}
