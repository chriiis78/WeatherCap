//
//  DetailsCityModels.swift
//  WeatherCap
//
//  Created by Christophe Mei on 07/10/2020.
//  Copyright (c) 2020 Capgemini. All rights reserved.
//

import UIKit
import CoreLocation

enum DetailsCity {
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

    enum GetCoordinate {
        struct Request {
            var city: String
        }
        struct Response {
            var coordinate: CLLocationCoordinate2D?
            var errorDescription: String?
        }
    }
}
