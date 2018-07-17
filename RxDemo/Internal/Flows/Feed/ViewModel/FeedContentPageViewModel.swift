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

class FeedContentPageViewModel: ViewModelProtocol {

    // MARK: Public Properties - Input

    let scrollToDirection: AnyObserver<UIPageViewControllerNavigationDirection>

    let changeActiveViewController: AnyObserver<(UIViewController, UIPageViewControllerNavigationDirection)>

    // MARK: Public Properties - Output

    let updateActiveViewController: Driver<(UIViewController, UIPageViewControllerNavigationDirection)>

    let currentViewControllerIndex: Observable<Int>

    var viewControllers: Driver<[OlimpTableViewController]>

    // MARK: Private Properties

    private let tableViewModels: [OlimpTableViewModel]

    private let disposeBag = DisposeBag()

    // MARK: Lyfecircle

    init(provider: MoyaProvider<OlimpBattle>, search: Observable<String?>? = nil) {
        let _scrollToDirection = PublishSubject<UIPageViewControllerNavigationDirection>()
        self.scrollToDirection = _scrollToDirection.asObserver()

        self.tableViewModels = OlimpTableType.cases().map({ OlimpTableViewModel(provider: provider, type: $0, search: search) })

        let _viewControllers = Observable.just(tableViewModels.map({ (vm) -> OlimpTableViewController in
            let vc = UIStoryboard(name: OlimpTableViewController.identifier, bundle: nil).instantiateInitialViewController() as! OlimpTableViewController
            vc.viewModel = vm
            return vc
        }))

        let _activeViewController = PublishSubject<(UIViewController, UIPageViewControllerNavigationDirection)>()
        self.changeActiveViewController = _activeViewController.asObserver()
        self.updateActiveViewController = _activeViewController.asDriver(onErrorJustReturn: (UIViewController(), .forward))
        self.currentViewControllerIndex = _activeViewController.withLatestFrom(Observable.combineLatest(_activeViewController, _viewControllers)).map({ vc, vcs in
            return vcs.index(of: vc.0 as! OlimpTableViewController)
        }).filter({ $0 != nil }).map({ $0! }).asObservable()

        self.viewControllers = _viewControllers.asDriver(onErrorJustReturn: [])

        //Business logic

        _scrollToDirection.filter({ $0 == .forward }).withLatestFrom(Observable.combineLatest(_activeViewController, _viewControllers) )
            .map({ $0.1[safe: $0.1.index(of: $0.0.0 as! OlimpTableViewController)! + 1]}).filter({ $0 != nil }).map({ ($0!, .forward) })
            .bind(to: _activeViewController).disposed(by: disposeBag)

        _scrollToDirection.filter({ $0 == .reverse }).withLatestFrom(Observable.combineLatest(_activeViewController, _viewControllers) )
            .map({ $0.1[safe: $0.1.index(of: $0.0.0 as! OlimpTableViewController)! - 1]}).filter({ $0 != nil }).map({ ($0!, .reverse) })
            .bind(to: _activeViewController).disposed(by: disposeBag)
    }
}
