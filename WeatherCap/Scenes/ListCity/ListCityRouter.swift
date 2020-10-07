//
//  ListCityRouter.swift
//  WeatherCap
//
//  Created by Christophe Mei on 07/10/2020.
//  Copyright (c) 2020 Capgemini. All rights reserved.
//

import UIKit

@objc protocol ListCityRoutingLogic {
    func routeToDetailsCity(segue: UIStoryboardSegue?)
    func routeToAddCity(segue: UIStoryboardSegue?)
}

protocol ListCityDataPassing {
    var dataStore: ListCityDataStore? { get }
}

class ListCityRouter: NSObject, ListCityRoutingLogic, ListCityDataPassing {
    weak var viewController: ListCityViewController?
    var dataStore: ListCityDataStore?

    // MARK: Routing

    func routeToDetailsCity(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! DetailsCityViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToDetailsCity(source: dataStore!, destination: &destinationDS)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "DetailsCityViewController") as! DetailsCityViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToDetailsCity(source: dataStore!, destination: &destinationDS)
            navigateToDetailsCity(source: viewController!, destination: destinationVC)
        }
    }

    func routeToAddCity(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! AddCityViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToAddCity(source: dataStore!, destination: &destinationDS)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "AddCityViewController") as! AddCityViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToAddCity(source: dataStore!, destination: &destinationDS)
            navigateToAddCity(source: viewController!, destination: destinationVC)
        }
    }

    // MARK: Navigation

    func navigateToDetailsCity(source: ListCityViewController, destination: DetailsCityViewController) {
        source.show(destination, sender: nil)
    }

    func navigateToAddCity(source: ListCityViewController, destination: AddCityViewController) {
        source.show(destination, sender: nil)
    }

    // MARK: Passing data

    func passDataToDetailsCity(source: ListCityDataStore, destination: inout DetailsCityDataStore) {
        if let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row {
            destination.city = source.cities[selectedRow]
        }
    }

    func passDataToAddCity(source: ListCityDataStore, destination: inout AddCityDataStore) {
    }
}
