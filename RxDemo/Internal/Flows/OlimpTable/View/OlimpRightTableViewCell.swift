//
//  OlimpRightTableViewCell.swift
//  RxDemo
//
//  Created by Dmitrii Bagrov on 16/07/2018.
//  Copyright © 2018 Dmitrii Bagrov. All rights reserved.
//

import Foundation
import UIKit

class OlimpRightTableViewCell: DisposableTableViewCell {

    // MARK: Outlets

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var detailsLabel: UILabel!

    func bind(with viewModel: OlimpTableCellViewModel) {
        viewModel.title.drive(titleLabel.rx.text).disposed(by: disposeBag)
        viewModel.text.drive(detailsLabel.rx.text).disposed(by: disposeBag)
    }
    
}
