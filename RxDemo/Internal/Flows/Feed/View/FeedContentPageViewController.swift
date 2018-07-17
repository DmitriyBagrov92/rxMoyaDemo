//
//  FeedContentPageViewController.swift
//  RxDemo
//
//  Created by Dmitrii Bagrov on 16/07/2018.
//  Copyright © 2018 Dmitrii Bagrov. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class FeedContentPageViewController: UIPageViewController, ViewControllerProtocol, Identifierable {

    // MARK - ViewControllerProtocol Properties

    typealias VM = FeedContentPageViewModel

    var viewModel: FeedContentPageViewModel!

    // MARK: Private Properties

    private var contentViewController: [UIViewController] = []

    private let disposeBag = DisposeBag()

    // MARK: ViewController Lyfecircle

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self

        bindUI()
    }

}

extension FeedContentPageViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = contentViewController.index(of: viewController) ?? 0
        return contentViewController[safe: currentIndex + 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = contentViewController.index(of: viewController) ?? 0
        return contentViewController[safe: currentIndex - 1]
    }

}

extension FeedContentPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            viewModel.changeActiveViewController.onNext((previousViewControllers.last!, .forward))
        }
    }

}

private extension FeedContentPageViewController {

    func bindUI() {
        viewModel.viewControllers.drive(onNext: { [weak self] (viewControllers) in
            self?.contentViewController = viewControllers
            self?.setViewControllers([viewControllers.first!], direction: .forward, animated: false, completion: nil)
            self?.viewModel.changeActiveViewController.onNext((viewControllers.first!, .forward))
        }).disposed(by: disposeBag)

        viewModel.updateActiveViewController.drive(onNext: { [weak self] (viewController, direction) in
            self?.setViewControllers([viewController], direction: direction, animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }

}
