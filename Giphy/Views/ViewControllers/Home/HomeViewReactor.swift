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
        isRefreshing: false,
        isLoading: false,
        sections: [],
        offset: 0,
        hasNext: false,
        totalCount: 0
    )
    
    private let gifsService: GIFsService
    init(gifsService: GIFsService) {
        self.gifsService = gifsService
    }
    
    enum Action {
        case refresh
        case loadMore
    }
    
    enum Mutation {
        case setLoading(Bool)
        case setItems([GIF], totalCount: Int)
        case appendItems([GIF])
    }
    
    struct State {
        var isRefreshing: Bool
        var isLoading: Bool
        var sections: [GIFListViewSection]
        var offset: Int
        var hasNext: Bool
        var totalCount: Int
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            let startLoading: Observable<Mutation> = .just(.setLoading(true))
            let fetching: Observable<Mutation> = gifsService.trending(
                limit: Consts.limit,
                offset: 0
            ).asObservable()
            .map { ($0.data, totalCount: $0.pagination.totalCount) }
            .map(Mutation.setItems)
            let endLoading: Observable<Mutation> = .just(.setLoading(false))
            return .concat(startLoading, fetching, endLoading)
            
        case .loadMore:
            guard !currentState.isLoading,
                  currentState.hasNext else { return .empty() }
            let startLoading: Observable<Mutation> = .just(.setLoading(true))
            let fetching: Observable<Mutation> = gifsService.trending(
                limit: Consts.limit,
                offset: currentState.offset
            ).asObservable()
            .map { .appendItems($0.data) }
            let endLoading: Observable<Mutation> = .just(.setLoading(false))
            return .concat(startLoading, fetching, endLoading)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case let .setItems(items, totalCount):
            newState.sections = [.gifs(items.map(GIFListViewSectionItem.gif))]
            newState.totalCount = totalCount
            newState.offset = Consts.limit
        case let .appendItems(items):
            if let section = newState.sections.first {
                let sectionItems = items.map(GIFListViewSectionItem.gif)
                newState.sections = [.appended(from: section, items: sectionItems)]
            }
            newState.offset += Consts.limit
        }
        newState.hasNext = newState.offset < newState.totalCount
        return newState
    }
    
    
}
