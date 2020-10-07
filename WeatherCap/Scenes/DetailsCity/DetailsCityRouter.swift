//
//  DetailsCityRouter.swift
//  WeatherCap
//
//  Created by Christophe Mei on 07/10/2020.
//  Copyright (c) 2020 Capgemini. All rights reserved.
//

import UIKit

@objc protocol DetailsCityRoutingLogic {
}

protocol DetailsCityDataPassing {
    var dataStore: DetailsCityDataStore? { get }
}

class DetailsCityRouter: NSObject, DetailsCityRoutingLogic, DetailsCityDataPassing {
    weak var viewController: DetailsCityViewController?
    var dataStore: DetailsCityDataStore?
}
