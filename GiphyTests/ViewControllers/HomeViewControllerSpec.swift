//
//  HomeViewControllerSpec.swift
//  GiphyTests
//
//  Created by 현진 on 2021/01/19.
//

import Nimble
import Quick
import Resolver
import RxSwift
import RxBlocking

@testable import Giphy

class HomeViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        var viewController: HomeViewController!
        var reactor: HomeViewReactor!
        
        beforeEach {
            viewController = HomeViewController()
            reactor = Resolver.resolve() as HomeViewReactor
            reactor.stub.isEnabled = true
            viewController.reactor = reactor
        }
        
        describe("refresh control") {
            context("when isRefresh is true") {
                beforeEach {
                    reactor.stub.state.value.isRefreshing = true
                }
                it("is refreshing") {
                    expect(viewController.refreshControl.isRefreshing).to(beTrue())
                }
            }
//            context("when isRefresh is false") {
//                beforeEach {
//                    reactor.stub.state.value.isRefreshing = false
//                }
//                it("isn't refreshing") {
//                    expect(viewController.refreshControl.isRefreshing).to(beFalse())
//                }
//            }
        }
        
    }
    
}
