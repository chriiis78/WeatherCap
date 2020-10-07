//
//  AddCityWorker.swift
//  WeatherCap
//
//  Created by Christophe Mei on 07/10/2020.
//  Copyright (c) 2020 Capgemini. All rights reserved.
//

import UIKit
import MapKit

typealias FetchCitiesResponseHandler = (_ response: AddCity.FetchCities.Response) -> Void

class AddCityWorker {
    func fetchCities(request: AddCity.FetchCities.Request, success: @escaping(FetchCitiesResponseHandler), fail: @escaping(FetchCitiesResponseHandler)) {
        let mapMequest = MKLocalSearch.Request()
        mapMequest.naturalLanguageQuery = request.name
        let localSearch = MKLocalSearch(request: mapMequest)
        localSearch.start { (searchResponse, _) in
            guard let items = searchResponse?.mapItems else {
                return
            }
            
            var listCities: [String] = []
            for city in items {
                let name = (city.placemark.locality ?? "") + ", " + (city.placemark.country ?? "")

                listCities.append(name)
            }
            listCities = Array(Set(listCities))
            success(AddCity.FetchCities.Response.init(cities: listCities))
        }
    }
}
