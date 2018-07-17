//
//  FeedViewModel.swift
//  RxDemo
//
//  Created by Dmitrii Bagrov on 16/07/2018.
//  Copyright © 2018 Dmitrii Bagrov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

class FeedViewModel: ViewModelProtocol {

    // MARK: Public Properties - Input

    let scrollToLeftButtonAction: AnyObserver<Void>

    let scrollToRightButtonAction: AnyObserver<Void>

    // MARK: Public Properties

    var feedContentPageViewModel: FeedContentPageViewModel

    // MARK: Private Properties

    let disposeBag = DisposeBag()

    // MARK: Lyfecircle

    init(provider: MoyaProvider<OlimpBattle>) {
        self.feedContentPageViewModel = FeedContentPageViewModel(provider: provider)

        let _scrollToLeftAction = PublishSubject<Void>()
        self.scrollToLeftButtonAction = _scrollToLeftAction.asObserver()

        let _scrollToRightAction = PublishSubject<Void>()
        self.scrollToRightButtonAction = _scrollToRightAction.asObserver()

        //Business Logic

        _scrollToLeftAction.map({ ScrollDirection.left }).bind(to: self.feedContentPageViewModel.scrollToDirection).disposed(by: disposeBag)
        _scrollToRightAction.map({ ScrollDirection.right }).bind(to: self.feedContentPageViewModel.scrollToDirection).disposed(by: disposeBag)
    }

}
