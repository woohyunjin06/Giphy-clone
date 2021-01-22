//
//  DetailViewReactor.swift
//  Giphy
//
//  Created by 현진 on 2021/01/20.
//

import ReactorKit
import Resolver
import RxSwift

class DetailViewReactor: Reactor {
    
    let initialState: State
    init(
        id: String,
        ratio: Float
    ) {
        self.initialState = State(
            id: id,
            ratio: ratio
        )
    }
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        let id: String
        let ratio: Float
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        state
    }
    
}
