//
//  OlimpLeftTableViewCell.swift
//  RxDemo
//
//  Created by Dmitrii Bagrov on 16/07/2018.
//  Copyright © 2018 Dmitrii Bagrov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class OlimpLeftTableViewCell: DisposableTableViewCell {

    func bind(with viewModel: OlimpTableCellViewModel) {
        viewModel.title.drive(textLabel!.rx.text).disposed(by: disposeBag)
        viewModel.text.drive(detailTextLabel!.rx.text).disposed(by: disposeBag)
    }

}
