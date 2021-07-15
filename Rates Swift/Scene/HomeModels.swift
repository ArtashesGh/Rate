//
//  HomeModels.swift
//  Rates Swift
//
//  Created by Artashes Noknok on 7/16/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Home
{
    // MARK: Use cases
    
    enum RatesModel
    {
        struct Request
        {
        }
        struct Response
        {
            var rates : RatesListResponse
        }
        struct ViewModel
        {
            var ratesList : RateDispModel
        }
    }
}