//
//  FeedCoordinator.swift
//  RxDemo
//
//  Created by Dmitrii Bagrov on 16/07/2018.
//  Copyright © 2018 Dmitrii Bagrov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Swinject
import UIKit

class FeedCoordinator: CoordinatorProtocol {

    // MARK: CoordinatorProtocol Methods

    func start(from viewController: UIViewController) -> Observable<Void> {
        let nvc = UIStoryboard(name: FeedViewController.identifier, bundle: nil).instantiateInitialViewController() as! UINavigationController
        let vc = nvc.topViewController as? FeedViewController

        let feedViewModel = FeedViewModel()
        vc?.viewModel = feedViewModel

        viewController.present(nvc, animated: true, completion: nil)
        return Observable.never()
    }

    func coordinate(to coordinator: CoordinatorProtocol, from viewController: UIViewController) -> Observable<Void> {
        return coordinator.start(from: viewController)
    }
    
}
