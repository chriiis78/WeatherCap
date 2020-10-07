//
//  WeatherModel.swift
//  WeatherCap
//
//  Created by Christophe Mei on 07/10/2020.
//

struct WeatherModel {
    enum FetchCity {
        struct Request {
        }
        struct Response {
            var weather: Weather?
            var errorMessage: String?
        }
    }
}
