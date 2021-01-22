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
        id: String
    ) {
        self.initialState = State(
            id: id
        )
    }
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        let id: String
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        state
    }
    
}
