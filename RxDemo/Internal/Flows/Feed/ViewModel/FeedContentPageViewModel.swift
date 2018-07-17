//
//  FeedContentPageViewModel.swift
//  RxDemo
//
//  Created by Dmitrii Bagrov on 16/07/2018.
//  Copyright © 2018 Dmitrii Bagrov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import UIKit

enum ScrollDirection {
    case left
    case right
}

class FeedContentPageViewModel: ViewModelProtocol {

    // MARK: Public Properties - Input

    let scrollToDirection: AnyObserver<ScrollDirection>

    let changeActiveViewController: AnyObserver<UIViewController>

    // MARK: Public Properties - Output

    let updateActiveViewController: Driver<UIViewController>

    var viewControllers: Driver<[OlimpTableViewController]>

    // MARK: Private Properties

    private let tableViewModels: [OlimpTableViewModel]

    private let disposeBag = DisposeBag()

    // MARK: Lyfecircle

    init(provider: MoyaProvider<OlimpBattle>, search: Observable<String?>? = nil) {
        let _scrollToDirection = PublishSubject<ScrollDirection>()
        self.scrollToDirection = _scrollToDirection.asObserver()

        let _activeViewController = PublishSubject<UIViewController>()
        self.changeActiveViewController = _activeViewController.asObserver()
        self.updateActiveViewController = _activeViewController.asDriver(onErrorJustReturn: UIViewController())

        self.tableViewModels = OlimpTableType.cases().map({ OlimpTableViewModel(provider: provider, type: $0, search: search) })

        let _viewControllers = Observable.just(tableViewModels.map({ (vm) -> OlimpTableViewController in
            let vc = UIStoryboard(name: OlimpTableViewController.identifier, bundle: nil).instantiateInitialViewController() as! OlimpTableViewController
            vc.viewModel = vm
            return vc
        }))
        self.viewControllers = _viewControllers.asDriver(onErrorJustReturn: [])

        //Business logic

        _scrollToDirection.filter({ $0 == .left }).withLatestFrom(Observable.combineLatest(_activeViewController, _viewControllers) )
            .map({ $0.1[safe: $0.1.index(of: $0.0 as! OlimpTableViewController)! - 1]}).filter({ $0 != nil }).map({ $0! })
            .bind(to: _activeViewController).disposed(by: disposeBag)

        _scrollToDirection.filter({ $0 == .right }).withLatestFrom(Observable.combineLatest(_activeViewController, _viewControllers) )
            .map({ $0.1[safe: $0.1.index(of: $0.0 as! OlimpTableViewController)! + 1]}).filter({ $0 != nil }).map({ $0! })
            .bind(to: _activeViewController).disposed(by: disposeBag)
    }
}
