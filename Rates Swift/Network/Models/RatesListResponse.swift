//
//  RatesListResponse.swift
//  Rate Swift
//
//  Created by Artashes Noknok on 7/16/21.
//

import UIKit

// MARK: - RatesListResponse

struct RatesListResponse: Codable {
    let code: Int
    let messageTitle, message, rid: String
    let downloadDate: String?
    let rates: [Rate]?
    let productState: Int?
    let ratesDate: String?
}
