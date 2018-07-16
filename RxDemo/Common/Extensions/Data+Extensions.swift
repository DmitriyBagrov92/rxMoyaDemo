//
//  Data+Extensions.swift
//  RxDemo
//
//  Created by Dmitrii Bagrov on 16/07/2018.
//  Copyright © 2018 Dmitrii Bagrov. All rights reserved.
//

import Foundation

extension Data {

    var json: [String: Any]?? {
        return try? JSONSerialization.jsonObject(with: self, options: []) as? [String: Any]
    }

}
