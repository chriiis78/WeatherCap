//
//  DetailsCityWorker.swift
//  WeatherCap
//
//  Created by Christophe Mei on 07/10/2020.
//  Copyright (c) 2020 Capgemini. All rights reserved.
//

import UIKit
import CoreLocation

typealias GetCoordinateResponseHandler = (_ response: DetailsCity.GetCoordinate.Response) -> Void

class DetailsCityWorker {
    func getCoordinate(request: DetailsCity.GetCoordinate.Request,
                       success: @escaping GetCoordinateResponseHandler,
                       fail: @escaping GetCoordinateResponseHandler) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(request.city) { (placemark, error) in
            if let error = error {
                fail(DetailsCity.GetCoordinate.Response(errorDescription: error.localizedDescription))
            }
            if let coordinate = placemark?.first?.location?.coordinate {
                success(DetailsCity.GetCoordinate.Response(coordinate: coordinate))
            }
        }
    }
}
