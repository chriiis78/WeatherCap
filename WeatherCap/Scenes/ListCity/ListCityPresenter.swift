//
//  ListCityPresenter.swift
//  WeatherCap
//
//  Created by Christophe Mei on 07/10/2020.
//  Copyright (c) 2020 Capgemini. All rights reserved.
//

import UIKit

protocol ListCityPresentationLogic {
    func presentCities(response: ListCity.GetCities.Response)
}

class ListCityPresenter: ListCityPresentationLogic {
    weak var viewController: ListCityDisplayLogic?

    func presentCities(response: ListCity.GetCities.Response) {
        let viewModel = ListCity.GetCities.ViewModel(cities: response.cities)
        viewController?.displayCities(viewModel: viewModel)
    }
}
