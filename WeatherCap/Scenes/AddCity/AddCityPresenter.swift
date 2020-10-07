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

    func presentCities(response: AddCity.FetchCities.Response) {
        if let cities = response.cities {
            let viewModel = AddCity.FetchCities.ViewModel(cities: cities)
            viewController?.displayCities(viewModel: viewModel)
        }
    }
}
