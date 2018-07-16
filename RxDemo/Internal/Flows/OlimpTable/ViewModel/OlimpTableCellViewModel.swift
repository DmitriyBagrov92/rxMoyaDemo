//
//  OlimpTableCellViewModel.swift
//  RxDemo
//
//  Created by Dmitrii Bagrov on 16/07/2018.
//  Copyright © 2018 Dmitrii Bagrov. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class OlimpTableCellViewModel: ViewModelProtocol {

    // MARK: Public Properties - Output

    let title: Driver<String?>

    let text: Driver<String?>

    // MARK: Lyfecircle

    init(item: OlimpBattleItem) {
        self.title = BehaviorSubject<String?>(value: item.title).asDriver(onErrorJustReturn: nil)
        self.text = BehaviorSubject<String?>(value: item.text).asDriver(onErrorJustReturn: nil)
    }

}
