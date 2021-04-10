//
//  FavoriteCountryStore.swift
//  FavoriteCountries
//
//  Created by Janiffer.Cho on 4/7/21.
//

import Foundation

class FavoriteCountryManager {
    let favoriteCountriesJSONUrl = URL(fileURLWithPath: "FavoriteCountries", relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
    
    var favoriteCountries: [Country] = [] {
        didSet {
            saveJSONFavoriteCountries()
        }
    }
    
    init() {
        loadJSONFavoriteCountries()
    }
    
    func loadJSONFavoriteCountries() {
        let decoder = JSONDecoder()
        
        do {
            let favoriteCountriesData = try Data(contentsOf: favoriteCountriesJSONUrl)
            favoriteCountries = try decoder.decode([Country].self, from: favoriteCountriesData)
            
        } catch let error {
            print(error)
        }
    }
    
    private func saveJSONFavoriteCountries() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let favoriteCountriesData  = try encoder.encode(favoriteCountries)
            try favoriteCountriesData.write(to: favoriteCountriesJSONUrl)
            
        } catch let error {
            print(error)
        }
    }
}
