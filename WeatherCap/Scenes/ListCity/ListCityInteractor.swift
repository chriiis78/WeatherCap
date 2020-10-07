//
//  ListCityInteractor.swift
//  WeatherCap
//
//  Created by Christophe Mei on 07/10/2020.
//  Copyright (c) 2020 Capgemini. All rights reserved.
//

import UIKit

protocol ListCityBusinessLogic {
    func getCities(request: ListCity.GetCities.Request)
}

protocol ListCityDataStore {
    var cities: [String] { get set }
}

class ListCityInteractor: ListCityBusinessLogic, ListCityDataStore {
    var cities: [String] = [] {
        didSet {
            cities = Array(Set(cities))
            self.presenter?.presentCities(response: ListCity.GetCities.Response(cities: cities))
            updateData()
    }}
    var presenter: ListCityPresentationLogic?
    var dataWorker = DataWorker()
    //var name: String = ""

    // MARK: Do something

    func getCities(request: ListCity.GetCities.Request) {
        dataWorker.getCities { response in
            if let cities = response.cities {
                self.cities = cities
            }
        } fail: { response in
            print(response.errorMessage)
        }
    }

    func updateData() {
        dataWorker.saveCities(DataModel.SaveCities.Request(cities: cities)) { response in
            print(response)
        }
    }
}
