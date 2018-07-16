//
//  OlimpTableViewController.swift
//  RxDemo
//
//  Created by Dmitrii Bagrov on 16/07/2018.
//  Copyright © 2018 Dmitrii Bagrov. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class OlimpTableViewController: UITableViewController, ViewControllerProtocol, Identifierable {

    // MARK - ViewControllerProtocol Properties

    typealias VM = OlimpTableViewModel

    var viewModel: OlimpTableViewModel!

    // MARK: Public Properties

    private let disposeBag = DisposeBag()

    // MARK - ViewController Lyfecircle

    override func viewDidLoad() {
        super.viewDidLoad()

        bindUI()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}

private extension OlimpTableViewController {

    func bindUI() {
        let dataSource = RxTableViewSectionedReloadDataSource<OlimpItemsSection>(configureCell: { (ds, tv, ip, item) -> UITableViewCell in
            let section = ds[ip.section]
            switch section.type {
            case .left:
                let cell = tv.dequeueReusableCell(withIdentifier: OlimpLeftTableViewCell.identifier) as! OlimpLeftTableViewCell
                cell.bind(with: item)
                return cell
            case .right:
                let cell = tv.dequeueReusableCell(withIdentifier: OlimpRightTableViewCell.identifier) as! OlimpRightTableViewCell
                cell.bind(with: item)
                return cell
            }
        })

        viewModel.tableSections.drive(tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
}
