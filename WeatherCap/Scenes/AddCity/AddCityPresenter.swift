//
//  AddCityPresenter.swift
//  WeatherCap
//
//  Created by Christophe Mei on 07/10/2020.
//  Copyright (c) 2020 Capgemini. All rights reserved.
//

import UIKit

protocol AddCityPresentationLogic {
    func presentCities(response: AddCity.FetchCities.Response)
}

class AddCityPresenter: AddCityPresentationLogic {
    weak var viewController: AddCityDisplayLogic?

    // MARK: Do something

    func presentCities(response: AddCity.FetchCities.Response) {
        let viewModel = AddCity.FetchCities.ViewModel(cities: response.cities)
        viewController?.displayCities(viewModel: viewModel)
    }
}
