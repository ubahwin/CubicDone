import Foundation

protocol DictionaryConvertor: Codable { }

struct APIParameters {
    struct CurrentWeatherParams: Encodable {
        let lat: Double
        let lon: Double
        let appid: String
    }

    struct FiveDaysForecastParams: Encodable {
        let lat: Double
        let lon: Double
        let appid: String
    }
}
