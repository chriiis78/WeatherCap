//
//  WeatherWorker.swift
//  WeatherCap
//
//  Created by Christophe Mei on 07/10/2020.
//

import CoreLocation
import Alamofire

typealias FetchCityResponseHandler = (_ response: WeatherModel.FetchCity.Response) -> Void

class WeatherWorker {

    func fetchCity(coordinate: CLLocationCoordinate2D, success: @escaping(FetchCityResponseHandler), fail: @escaping(FetchCityResponseHandler)) {
        guard let apiUrl = Bundle.main.infoDictionary?["API_URL"] as? String,
            let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String,
            let apiLang = Bundle.main.infoDictionary?["API_LANG"] as? String
            else {
                print("error get API parameters")
                fail(WeatherModel.FetchCity.Response(errorMessage: "error get API parameters"))
                return
        }

        let parameters: Parameters = [
            "lon": coordinate.longitude,
            "lat": coordinate.latitude,
            "exclude": "minutely",
            "lang": apiLang,
            "units": "metric",
            "appid": apiKey
        ]

        let request = AF.request(apiUrl, method: .get, parameters: parameters)
        request.responseData { response in
            let decoder = JSONDecoder()
            switch response.result {
            case .success:
                guard let json = response.data else {
                    fail(WeatherModel.FetchCity.Response(errorMessage: "error: no response data"))
                    return
                }
                print(response.request)
                var weatherResult: Weather
                do {
                    weatherResult = try decoder.decode(Weather.self, from: json)
                    success(WeatherModel.FetchCity.Response(weather: weatherResult))
                } catch {
                    print(error.localizedDescription)
                    fail(WeatherModel.FetchCity.Response(errorMessage: error.localizedDescription))
                }
            case let .failure(error):
                print(error)
                fail(WeatherModel.FetchCity.Response(errorMessage: error.errorDescription))
            }
        }
    }
}
