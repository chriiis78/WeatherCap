//
//  DetailsCityInteractor.swift
//  WeatherCap
//
//  Created by Christophe Mei on 07/10/2020.
//  Copyright (c) 2020 Capgemini. All rights reserved.
//

import UIKit
import CoreLocation

protocol DetailsCityBusinessLogic {
    func fetchWeather(request: DetailsCity.FetchWeather.Request)
}

protocol DetailsCityDataStore {
    var city: String { get set }
    var weather: Weather { get set }
}

class DetailsCityInteractor: DetailsCityBusinessLogic, DetailsCityDataStore {
    var city: String = ""
    var weather = Weather()
    var presenter: DetailsCityPresentationLogic?
    var weatherWorker = WeatherWorker()
    var worker = DetailsCityWorker()

    // MARK: Fetch weather

    func fetchWeather(request: DetailsCity.FetchWeather.Request) {
        worker.getCoordinate(request: DetailsCity.GetCoordinate.Request(city: city), success: { response in
            if let coordinate = response.coordinate {
                self.weatherWorker.fetchCity(coordinate: coordinate) { response in
                    if let weather = response.weather {
                        self.weather = weather
                    }
                    self.presenter?.presentWeather(
                        response: DetailsCity.FetchWeather.Response(
                            cityName: self.city,
                            weather: self.weather))
                } fail: { response in
                    print(response.errorMessage)
                }
            }
        }, fail: { response in
            print(response.errorDescription)
        })
    }
}
