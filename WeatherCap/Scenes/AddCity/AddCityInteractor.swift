//
//  AddCityInteractor.swift
//  WeatherCap
//
//  Created by Christophe Mei on 07/10/2020.
//  Copyright (c) 2020 Capgemini. All rights reserved.
//

import UIKit

protocol AddCityBusinessLogic {
    func fetchCities(request: AddCity.FetchCities.Request)
}

protocol AddCityDataStore {
    var cities: [String] { get set }
}

class AddCityInteractor: AddCityBusinessLogic, AddCityDataStore {
    var cities: [String] = []

    var presenter: AddCityPresentationLogic?
    var worker = AddCityWorker()

    // MARK: Fetch cities

    func fetchCities(request: AddCity.FetchCities.Request) {
        worker.fetchCities(request: request, success: { response in
            if let cities = response.cities {
                self.cities = cities
                self.presenter?.presentCities(response: response)
            }
        }, fail: { response in
            print(response.errorDescription)
        })
    }
}
