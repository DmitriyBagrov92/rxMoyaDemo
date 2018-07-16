//
//  Page.swift
//  RxDemo
//
//  Created by Dmitrii Bagrov on 16/07/2018.
//  Copyright © 2018 Dmitrii Bagrov. All rights reserved.
//

import Foundation

protocol Page {
    var offset: Int { get }
    var limit: Int { get }
    var search: String? { get }

    var next: Page? { get }
}

struct FeedPage: Page, Codable {

    var offset: Int = 0

    var limit: Int = 10

    var search: String?

    var next: Page? {
        //TODO: Add additinal logic on last page (return nil)
        return FeedPage(offset: offset + limit, limit: limit, search: search)
    }

}
