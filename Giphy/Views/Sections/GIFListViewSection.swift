//
//  GIFListViewSection.swift
//  Giphy
//
//  Created by 현진 on 2021/01/11.
//

import RxDataSources

enum GIFListViewSection {
  case gifs([ShotListViewSectionItem])
}

extension GIFListViewSection: SectionModelType {
    var items: [ShotListViewSectionItem] {
        switch self {
        case .gifs(let items): return items
        }
    }

    init(original: GIFListViewSection, items: [ShotListViewSectionItem]) {
        switch original {
        case .gifs: self = .gifs(items)
        }
    }
    
    static func appended(
        from original: GIFListViewSection,
        items: [ShotListViewSectionItem]
    ) -> GIFListViewSection {
        switch original {
        case let .gifs(originalItems):
            return .gifs(originalItems + items)
        }
    }
}

enum ShotListViewSectionItem {
    case gif(GIF)
}
