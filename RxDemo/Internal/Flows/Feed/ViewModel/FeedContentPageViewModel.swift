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

    // MARK: Public Properties - Output

    var viewControllers: Driver<[OlimpTableViewController]>

    // MARK: Private Properties

    private let tableViewModels: [OlimpTableViewModel]

    // MARK: Lyfecircle

    init(provider: MoyaProvider<OlimpBattle>) {
        self.tableViewModels = OlimpTableType.cases().map({ OlimpTableViewModel(provider: provider, type: $0) })

        self.viewControllers = Observable.just(tableViewModels.map({ (vm) -> OlimpTableViewController in
            let vc = UIStoryboard(name: OlimpTableViewController.identifier, bundle: nil).instantiateInitialViewController() as! OlimpTableViewController
            vc.viewModel = vm
            return vc
        })).asDriver(onErrorJustReturn: [])
    }
}
