//
//  OlimpTableViewModel.swift
//  RxDemo
//
//  Created by Dmitrii Bagrov on 16/07/2018.
//  Copyright © 2018 Dmitrii Bagrov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import RxDataSources

enum OlimpTableType: Int, EnumCollection {
    case left
    case right
    //TODO: In future can be widen
}

extension OlimpTableType {
    func requestType(with page: FeedPage) -> OlimpBattle {
        switch self {
        case .left:
            return .left(page)
        case .right:
            return .right(page)
        }
    }
}

struct OlimpItemsSection {
    var type: OlimpTableType
    var items: [OlimpTableCellViewModel]
}

extension OlimpItemsSection: SectionModelType {
    typealias Item = OlimpTableCellViewModel

    init(original: OlimpItemsSection, items: [Item]) {
        self = original
        self.items = items
    }
}

class OlimpTableViewModel: ViewModelProtocol {

    // MARK: Public Properties: Input

    let tableWillDisplayRow: AnyObserver<IndexPath>

    // MARK: Public Properties: Output

    let tableSections: Driver<[OlimpItemsSection]>

    // MARK: Private Properties

    private let disposeBag = DisposeBag()

    // MARK: lyfecircle

    init(provider: MoyaProvider<OlimpBattle>, type: OlimpTableType) {
        let _lastTableRow = PublishSubject<IndexPath>()
        self.tableWillDisplayRow = _lastTableRow.asObserver()

        let page = BehaviorSubject<FeedPage>(value: FeedPage())
        let olimpItems = BehaviorSubject<[OlimpBattleItem]>(value: [])

        self.tableSections = olimpItems.map({ items in
            let cellViewModels = items.map({ OlimpTableCellViewModel(item: $0) })
            return [OlimpItemsSection(type: type, items: cellViewModels)]
        }).asDriver(onErrorJustReturn: [])

        //Business Logic

        page.flatMapLatest({ provider.rx.request(type.requestType(with: $0)).map([OlimpBattleItem].self) }).map({ try! olimpItems.value() + $0 }).bind(to: olimpItems).disposed(by: disposeBag)

        _lastTableRow.filter({ (ip) -> Bool in
            let items = try? olimpItems.value()
            return (items?.count ?? Int.max) - 1 == ip.row
        })
        .withLatestFrom(page)
        .map({ $0.next as? FeedPage })
        .filter({ $0 != nil})
        .map({ $0! })
        .bind(to: page)
        .disposed(by: disposeBag)


    }

}
