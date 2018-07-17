//
//  AboutUserViewController.swift
//  Epilepsy
//
//  Created by Dmitrii Bagrov on 19/03/2018.
//  Copyright © 2018 DmitriyBagrov. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class FeedViewController: UIViewController, ViewControllerProtocol, Identifierable {

    // MARK - ViewControllerProtocol Properties

    typealias VM = FeedViewModel

    var viewModel: FeedViewModel!

    // MARK: IBOutlets - Views

    @IBOutlet weak var toLeftButton: UIButton!

    @IBOutlet weak var toRightButton: UIButton!
    
    @IBOutlet weak var contentPageControl: UIPageControl!
    
    // MARK: Private Properties

    private let searchController = UISearchController(searchResultsController: nil)

    private let disposeBag = DisposeBag()

    // MARK - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindUI()
    }

    //TODO: Temporary using of segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == FeedContentPageViewController.identifier, let vc = segue.destination as? FeedContentPageViewController {
            vc.viewModel = viewModel.feedContentPageViewModel
        }
    }

}

// MARK - UISearchResultsUpdating

extension FeedViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
    }

}

private extension FeedViewController {

    func setupUI() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }

    func bindUI() {
        toLeftButton.rx.tap.bind(to: viewModel.scrollToLeftButtonAction).disposed(by: disposeBag)
        toRightButton.rx.tap.bind(to: viewModel.scrollToRightButtonAction).disposed(by: disposeBag)

        searchController.searchBar.rx.text.orEmpty
        .throttle(0.3, scheduler: MainScheduler.instance).distinctUntilChanged()
        .bind(to: viewModel.searchText).disposed(by: disposeBag)

        viewModel.pageControlValue.drive(contentPageControl.rx.currentPage).disposed(by: disposeBag)
    }

}

