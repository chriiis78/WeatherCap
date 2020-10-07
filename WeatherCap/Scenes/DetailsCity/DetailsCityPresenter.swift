//
//  DetailsCityPresenter.swift
//  WeatherCap
//
//  Created by Christophe Mei on 07/10/2020.
//  Copyright (c) 2020 Capgemini. All rights reserved.
//

import UIKit

protocol DetailsCityPresentationLogic {
    func presentWeather(response: DetailsCity.FetchWeather.Response)
}

class DetailsCityPresenter: DetailsCityPresentationLogic {
    weak var viewController: DetailsCityDisplayLogic?

    func presentWeather(response: DetailsCity.FetchWeather.Response) {
        let viewModel = DetailsCity.FetchWeather.ViewModel(
            cityName: response.cityName,
            temp: "\(Int(response.weather.current?.temp ?? 0.0))°",
            weatherDescription: response.weather.current?.weather?.first?.weatherDescription ?? "",
            icon: UIImage(imageLiteralResourceName: response.weather.current?.weather?.first?.icon ?? ""))
        viewController?.displayWeather(viewModel: viewModel)
    }
}
