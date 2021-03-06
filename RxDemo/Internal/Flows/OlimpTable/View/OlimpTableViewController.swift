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

class OlimpTableViewController: UIViewController, ViewControllerProtocol, Identifierable {
    
    // MARK: Public Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK - ViewControllerProtocol Properties
    
    typealias VM = OlimpTableViewModel
    
    var viewModel: OlimpTableViewModel!
    
    // MARK: Private Properties
    
    private let disposeBag = DisposeBag()

    private let refreshControl = UIRefreshControl()
    
    // MARK - ViewController Lyfecircle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindUI()
    }
    
}

extension OlimpTableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.tableWillDisplayRow.onNext(indexPath)
    }

}

private extension OlimpTableViewController {

    func setupUI() {
        tableView.refreshControl = refreshControl
    }
    
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
        
        viewModel.tableSections.drive(self.tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)

        refreshControl.rx.controlEvent(.valueChanged).bind(to: viewModel.tableRequireRefresh).disposed(by: disposeBag)
        viewModel.tableIsRefreshing.drive(refreshControl.rx.isRefreshing).disposed(by: disposeBag)
    }
}
