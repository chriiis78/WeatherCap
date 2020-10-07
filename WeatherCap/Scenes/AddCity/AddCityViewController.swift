//
//  AddCityViewController.swift
//  WeatherCap
//
//  Created by Christophe Mei on 07/10/2020.
//  Copyright (c) 2020 Capgemini. All rights reserved.
//

import UIKit

protocol AddCityDisplayLogic: class {
    func displayCities(viewModel: AddCity.FetchCities.ViewModel)
}

class AddCityViewController: UITableViewController, AddCityDisplayLogic {

    var interactor: AddCityBusinessLogic?
    var router: (NSObjectProtocol & AddCityRoutingLogic & AddCityDataPassing)?

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
        let interactor = AddCityInteractor()
        let presenter = AddCityPresenter()
        let router = AddCityRouter()
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

    @IBOutlet weak var searchBar: UISearchBar!

    var listCities: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        searchBar.becomeFirstResponder()
    }

    // MARK: Add city

    func fetchCities() {
        if let text = searchBar.text {
            let request = AddCity.FetchCities.Request(name: text)
            interactor?.fetchCities(request: request)
        }
    }

    func displayCities(viewModel: AddCity.FetchCities.ViewModel) {
        self.listCities = viewModel.cities
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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToParent(segue: nil)
    }
}

extension AddCityViewController: UISearchBarDelegate {

    // MARK: SearchBar

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        fetchCities()
        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
