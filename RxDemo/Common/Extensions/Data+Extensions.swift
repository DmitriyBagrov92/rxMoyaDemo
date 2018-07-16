//
//  Data+Extensions.swift
//  RxDemo
//
//  Created by Dmitrii Bagrov on 16/07/2018.
//  Copyright © 2018 Dmitrii Bagrov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

extension Data {

    var json: [String: Any]?? {
        return try? JSONSerialization.jsonObject(with: self, options: []) as? [String: Any]
    }

}

//extension ObservableType where E == Response {
//
//    private func mapArrayResponse() -> Observable<E> {
//        return map { response -> Response in
//            // your map
//        }
//    }
//
//    func mapArray<T: Codable>(type: T.Type) -> Observable<[T]?> {
//        return mapArrayResponse().mapArrayOptional(type)
//    }
//}
