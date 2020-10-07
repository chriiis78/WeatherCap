//
//  ListCityModels.swift
//  WeatherCap
//
//  Created by Christophe Mei on 07/10/2020.
//  Copyright (c) 2020 Capgemini. All rights reserved.
//

import UIKit

enum ListCity {
    enum GetCities {
        struct Request {
        }
        struct Response {
            var cities: [String]
        }
        struct ViewModel {
            var cities: [String]
        }
    }
}
