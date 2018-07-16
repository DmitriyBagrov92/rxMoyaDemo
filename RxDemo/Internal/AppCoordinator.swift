//
//  AppCoordinator.swift
//  Epilepsy
//
//  Created by DmitriyBagrov on 16/11/2017.
//  Copyright © 2017 DmitriyBagrov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Swinject
import UIKit

class AppCoordinator: CoordinatorProtocol {

    // MARK: Private Properties

    private let container = Container()
    private let disposeBag = DisposeBag()

    // MARK: Lyfecircle

    init() {
    }

    // MARK: CoordinatorProtocol Methods

    func start(from viewController: UIViewController) -> Observable<Void> {
        viewController.rx.viewDidAppear.bind(onNext: { [unowned self] () in
            let _ = self.coordinate(to: FeedCoordinator(), from: viewController)
        }).disposed(by: disposeBag)
        return Observable.never()
    }

    func coordinate(to coordinator: CoordinatorProtocol, from viewController: UIViewController) -> Observable<Void> {
        return coordinator.start(from: viewController)
    }

}

// MARK: Private Methods

private extension AppCoordinator {

}

