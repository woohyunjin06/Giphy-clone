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
    
    var initialState: State = State()
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        state
    }
    
}
