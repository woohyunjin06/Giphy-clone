//
//  HomeViewReactor.swift
//  Giphy
//
//  Created by 현진 on 2021/01/11.
//

import ReactorKit
import Resolver
import RxSwift

class HomeViewReactor: Reactor {
    
    private struct Consts {
        static let limit = 50
    }
    
    var initialState: State = State(
        isLoading: false,
        sections: [.gifs([])],
        offset: 0
    )
    
    private let gifsService: GIFsService
    init(gifsService: GIFsService) {
        self.gifsService = gifsService
    }
    
    enum Action {
        case refresh
    }
    
    enum Mutation {
        case setLoading(Bool)
        case appendItems([GIF])
        case setOffset(Int)
    }
    
    struct State {
        var isLoading: Bool
        var sections: [GIFListViewSection]
        var offset: Int
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            let startLoading: Observable<Mutation> = .just(.setLoading(true))
            let fetching: Observable<Mutation> = gifsService.trending(
                limit: Consts.limit,
                offset: currentState.offset
            ).asObservable()
            .flatMap {
                Observable.from([
                    .setOffset($0.pagination.offset + Consts.limit),
                    .appendItems($0.data)
                ])
            }.debug()
            let endLoading: Observable<Mutation> = .just(.setLoading(false))
            
            return .concat(startLoading, fetching, endLoading)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case let .appendItems(items):
            if let section = newState.sections.first {
                let sectionItems = items.map(ShotListViewSectionItem.gif)
                newState.sections = [.appended(from: section, items: sectionItems)]
            }
        case let .setOffset(offset):
            newState.offset = offset
        }
        return newState
    }
    
    
}
