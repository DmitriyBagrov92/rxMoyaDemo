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

    // MARK: Private Properties

    private let disposeBag = DisposeBag()

    // MARK - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        bindUI()
    }

}

private extension FeedViewController {

    func bindUI() {
    }

}

