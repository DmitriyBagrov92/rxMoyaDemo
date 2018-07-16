//
//  OlimpbattleProvider.swift
//  RxDemo
//
//  Created by Dmitrii Bagrov on 16/07/2018.
//  Copyright © 2018 Dmitrii Bagrov. All rights reserved.
//

import Foundation
import Moya

enum OlimpBattle {
    case left(FeedPage)
    case right(FeedPage)
}

extension OlimpBattle: TargetType {

    var baseURL: URL { return URL(string: "http://dev.olimpbattle.com/v1/services/test")! }

    var path: String {
        switch self {
        case .left(_):
            return "/left"
        case .right(_):
            return "/right"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case .left(let page), .right(let page):
            let encodedPage = try! JSONEncoder().encode(page)
            return .requestParameters(parameters:encodedPage.json!!, encoding: URLEncoding.default)
        }
    }

    var validationType: ValidationType {
        return .none
    }

    var sampleData: Data {
        return Data()
    }

    var headers: [String : String]? {
        return nil
    }

}
