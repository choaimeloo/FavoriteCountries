//
//  CountryList.swift
//  FavoriteCountries
//
//  Created by Janiffer.Cho on 4/6/21.
//

import Foundation

struct Country: Codable, Equatable {
    var id: String
    var name: String
    var capitalCity: String
    var favoriteThings: String?
}

func ==(lhs: Country, rhs: Country) -> Bool {
    return lhs.id == rhs.id
}

extension Country {
    static func countries() -> [Country] {
        guard let url = Bundle.main.url(forResource: "countries", withExtension: "json"),
              let data = try? Data(contentsOf: url)
            else {
                return []
            }
    
        do {
            let decoder = JSONDecoder()
            let countries = try decoder.decode([Country].self, from: data)
                return countries.filter { (country: Country) in
                    !country.capitalCity.isEmpty
                }
        } catch {
            return []
        }
    }
}
