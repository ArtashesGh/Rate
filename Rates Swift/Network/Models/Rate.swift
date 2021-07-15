//
//  Rate.swift
//  Rate Swift
//
//  Created by Artashes Noknok on 7/16/21.
//

import UIKit

// MARK: - Rate
struct Rate: Codable {
    let tp: Int?
    let name: String?
    let from: Int?
    let currMnemFrom: String?
    let to: Int?
    let currMnemTo, basic, buy, sale: String?
    let deltaBuy, deltaSale: String?
}

// MARK: - RateDispModel
struct RateDispModel: Codable {
    let ratesList:[Rate]
}
