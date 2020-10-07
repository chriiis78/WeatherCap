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
    //var name: String = ""

    // MARK: Do something

    func fetchCities(request: AddCity.FetchCities.Request) {
        print("fetchCities")
        worker.fetchCities(request: request, success: { response in
            if response.cities.count != 0 {
                self.cities = response.cities
                self.presenter?.presentCities(response: response)
            }
        }, fail: { response in

        })
    }
}
