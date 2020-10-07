//
//  ListCityViewController.swift
//  WeatherCap
//
//  Created by Christophe Mei on 07/10/2020.
//  Copyright (c) 2020 Capgemini. All rights reserved.
//

import UIKit

protocol ListCityDisplayLogic: class {
    func displayCities(viewModel: ListCity.GetCities.ViewModel)
}

class ListCityViewController: UITableViewController, ListCityDisplayLogic {
    var interactor: ListCityBusinessLogic?
    var router: (NSObjectProtocol & ListCityRoutingLogic & ListCityDataPassing)?

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = ListCityInteractor()
        let presenter = ListCityPresenter()
        let router = ListCityRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.definesPresentationContext = true

        getCities()
    }

    // MARK: List Cities

    func getCities() {
        let request = ListCity.GetCities.Request()
        interactor?.getCities(request: request)
    }

    var listCities: [String] = []

    func displayCities(viewModel: ListCity.GetCities.ViewModel) {
        listCities = viewModel.cities
        tableView.reloadData()
    }

    // MARK: TableView

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        cell.textLabel?.text = listCities[indexPath.row]
        return cell
    }
}
