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

    // MARK: Public Properties

    var feedContentPageViewModel: FeedContentPageViewModel

    // MARK: Lyfecircle

    init(provider: MoyaProvider<OlimpBattle>) {
        self.feedContentPageViewModel = FeedContentPageViewModel(provider: provider)
    }

}
