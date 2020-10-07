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
    var worker = WeatherWorker()
    //var name: String = ""

    let geocoder = CLGeocoder()

    // MARK: Do something

    func fetchWeather(request: DetailsCity.FetchWeather.Request) {
        getCoordinates(success: { coordinate in
            print("getcoordinates success")
            self.worker.fetchCity(coordinate: coordinate) { response in
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
        }, fail: { error in
            print(error)
        })
    }

    func getCoordinates(success: @escaping (CLLocationCoordinate2D) -> Void,
                        fail: @escaping (Error) -> Void) {
        geocoder.geocodeAddressString(city) { (placemark, error) in
            if let error = error {
                fail(error)
            }
            if let coordinate = placemark?.first?.location?.coordinate {
                success(coordinate)
            }
        }
    }
}
