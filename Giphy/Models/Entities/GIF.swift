//
//  GIF.swift
//  Giphy
//
//  Created by 현진 on 2021/01/10.
//

import Foundation
import UIKit

struct GIF: Decodable {
    
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
    
    struct Images: Decodable {
        let image: Image
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: DynamicKey.self)
            
            var image: Image?
            for key in container.allKeys {
                if key.stringValue == "fixed_height_small",
                   let small = try? container.decodeIfPresent(Image.self, forKey: key) {
                    image = small
                    break
                } else if key.stringValue == "original",
                          let normal = try? container.decodeIfPresent(Image.self, forKey: key) {
                    image = normal
                }
            }
            
            if let image = image {
                self.image = image
            } else {
                fatalError()
            }
        }
        
        struct Image: Codable {
            let height, width, size: String
            let mp4: String
            
            var ratio: CGFloat {
                guard let imageHeight = Int(height),
                      let imageWidth = Int(width)
                else {
                    return 1
                }

                return CGFloat(imageHeight) / CGFloat(imageWidth)
            }
        }
        
    }
    
}
