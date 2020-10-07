//
//  DetailsCityViewController.swift
//  WeatherCap
//
//  Created by Christophe Mei on 07/10/2020.
//  Copyright (c) 2020 Capgemini. All rights reserved.
//

import UIKit

protocol DetailsCityDisplayLogic: class {
    func displayWeather(viewModel: DetailsCity.FetchWeather.ViewModel)
}

class DetailsCityViewController: UIViewController, DetailsCityDisplayLogic {
    var interactor: DetailsCityBusinessLogic?
    var router: (NSObjectProtocol & DetailsCityRoutingLogic & DetailsCityDataPassing)?

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
        let interactor = DetailsCityInteractor()
        let presenter = DetailsCityPresenter()
        let router = DetailsCityRouter()
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

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherTempLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeather()
    }

    // MARK: Do something

    //@IBOutlet weak var nameTextField: UITextField!

    func fetchWeather() {
        cityNameLabel.text = ""
        weatherDescriptionLabel.text = "Loading..."
        interactor?.fetchWeather(request: DetailsCity.FetchWeather.Request())
    }

    func displayWeather(viewModel: DetailsCity.FetchWeather.ViewModel) {
        cityNameLabel.text = viewModel.cityName
        weatherTempLabel.text = viewModel.temp
        weatherDescriptionLabel.text = viewModel.weatherDescription
        weatherImage.image = viewModel.icon
    }
}
