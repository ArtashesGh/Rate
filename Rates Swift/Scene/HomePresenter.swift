//
//  HomePresenter.swift
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

protocol HomePresentationLogic
{
    func presentGetedValue(response: Home.RatesModel.Response)
    func presentError(error: String)
    func showLoader()
    func hideLoader()
}

class HomePresenter: HomePresentationLogic
{
    weak var viewController: HomeDisplayLogic?
    
    // MARK: Geted Value
    
    func presentGetedValue(response: Home.RatesModel.Response)
    {
        let ratesDispModel = RateDispModel(ratesList: response.rates.rates ?? [])
        let viewModel = Home.RatesModel.ViewModel(ratesList: ratesDispModel)
        viewController?.displayValue(viewModel: viewModel)
    }
    
    func presentError(error: String) {
        viewController?.displayError(errorMesage: error)
    }
    
    func showLoader() {
        viewController?.showLoader()
    }
    func hideLoader() {
        viewController?.hideLoader()
    }
}
