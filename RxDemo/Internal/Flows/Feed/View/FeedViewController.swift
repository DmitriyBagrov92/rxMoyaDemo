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
    
    // MARK: Private Properties

    private let disposeBag = DisposeBag()

    // MARK - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        bindUI()
    }

    //TODO: Temporary using of segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == FeedContentPageViewController.identifier, let vc = segue.destination as? FeedContentPageViewController {
            vc.viewModel = viewModel.feedContentPageViewModel
        }
    }

}

private extension FeedViewController {

    func bindUI() {
        toLeftButton.rx.tap.bind(to: viewModel.scrollToLeftButtonAction).disposed(by: disposeBag)
        toRightButton.rx.tap.bind(to: viewModel.scrollToRightButtonAction).disposed(by: disposeBag)
    }

}

