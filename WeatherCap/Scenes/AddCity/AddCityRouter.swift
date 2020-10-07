//
//  AddCityRouter.swift
//  WeatherCap
//
//  Created by Christophe Mei on 07/10/2020.
//  Copyright (c) 2020 Capgemini. All rights reserved.
//

import UIKit

@objc protocol AddCityRoutingLogic {
    func routeToParent(segue: UIStoryboardSegue?)
}

protocol AddCityDataPassing {
    var dataStore: AddCityDataStore? { get }
}

class AddCityRouter: NSObject, AddCityRoutingLogic, AddCityDataPassing {
    weak var viewController: AddCityViewController?
    var dataStore: AddCityDataStore?

    // MARK: Routing
    func routeToParent(segue: UIStoryboardSegue?) {
        // Get the destination view controller and data store
        let destinationVC = viewController?.presentingViewController?.children.first as! ListCityViewController
        var destinationDS = destinationVC.router!.dataStore!

        // Pass data to the destination data store
        passDataToParent(source: dataStore!, destination: &destinationDS)

        // Navigate to the destination view controller
        navigateToParent(source: viewController!, destination: destinationVC)
    }

    // MARK: Navigation

    func navigateToParent(source: AddCityViewController, destination: ListCityViewController) {
        // Navigate backward (dismissing)
        source.dismiss(animated: true, completion: nil)
    }

    // MARK: Passing data

    func passDataToParent(source: AddCityDataStore, destination: inout ListCityDataStore) {
        // Pass data backward
        if let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row {
            print("selectedRow ", selectedRow)
            destination.cities.append(source.cities[selectedRow])
        }
    }
}
