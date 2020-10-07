//
//  DataWorker.swift
//  WeatherCap
//
//  Created by Christophe Mei on 07/10/2020.
//

import Foundation

typealias GetCitiesResponseHandler = (_ response: DataModel.GetCities.Response) -> Void
typealias SaveCitiesResponseHandler = (_ response: DataModel.SaveCities.Response) -> Void

class DataWorker {

    let userDefaults : UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func getCities(success: @escaping(GetCitiesResponseHandler), fail: @escaping(GetCitiesResponseHandler)) {
        if let cities = userDefaults.value(forKey: "cities") as? [String] {
            success(DataModel.GetCities.Response(cities: cities))
        } else {
            fail(DataModel.GetCities.Response(errorMessage: "Failed to get user cities"))
        }
    }

    func saveCities(_ request: DataModel.SaveCities.Request, completion: @escaping(SaveCitiesResponseHandler)) {
        userDefaults.setValue(request.cities, forKey: "cities")
        completion(DataModel.SaveCities.Response(message: "Cities saved"))
    }
}
