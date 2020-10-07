//
//  AddCityModels.swift
//  WeatherCap
//
//  Created by Christophe Mei on 07/10/2020.
//  Copyright (c) 2020 Capgemini. All rights reserved.
//

import UIKit

enum AddCity {
    enum FetchCities {
        struct Request {
            var name: String
        }
        struct Response {
            var cities: [String]
        }
        struct ViewModel {
            var cities: [String]
        }
    }
}
