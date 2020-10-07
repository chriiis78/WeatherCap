//
//  DataModel.swift
//  WeatherCap
//
//  Created by Christophe Mei on 07/10/2020.
//

struct DataModel {
    enum GetCities {
        struct Request {
        }
        struct Response {
            var cities: [String]?
            var errorMessage: String?
        }
    }

    enum SaveCities {
        struct Request {
            var cities: [String]?
        }
        struct Response {
            var message: String
        }
    }
}
