//
//  DetailsCityModels.swift
//  WeatherCap
//
//  Created by Christophe Mei on 07/10/2020.
//  Copyright (c) 2020 Capgemini. All rights reserved.
//

import UIKit

enum DetailsCity {
    // MARK: Use cases

    enum FetchWeather {
        struct Request {
        }
        struct Response {
            var cityName: String
            var weather: Weather
        }
        struct ViewModel {
            var cityName: String
            var temp: String
            var weatherDescription: String
            var icon: UIImage?
        }
    }
}
