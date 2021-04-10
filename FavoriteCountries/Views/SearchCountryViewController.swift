//
//  SearchCountryViewController.swift
//  FavoriteCountries
//
//  Created by Janiffer.Cho on 4/6/21.
//

import UIKit

class SearchCountryViewController: UIViewController {
    
    let favoriteCountryManager = FavoriteCountryManager()
    var countries: [Country] = []
    var favoriteCountries: [Country] = []
    var filteredCountries: [Country] = []
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        searchBar.delegate = self
        searchBar.placeholder = "Search Countries"
        tableView.delegate = self
        tableView.dataSource = self

        getCountries()
    }
    
    private func getCountries() {
        favoriteCountries = favoriteCountryManager.favoriteCountries
        
        countries = Country.countries().filter { !favoriteCountryManager.favoriteCountries.contains($0) }
    }

    var isSearchBarEmpty: Bool {
        return searchBar.text?.isEmpty ?? true
    }

    var isFiltering: Bool {
        return searchBar.isFirstResponder && !isSearchBarEmpty
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredCountries = countries.filter { (country: Country) -> Bool in
            guard !isSearchBarEmpty else {
                return false
            }
            return country.name.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
    private func getSelectedCountry(at indexPath: IndexPath) -> Country {
        let country: Country
        
        if isFiltering {
            country = filteredCountries[indexPath.row]
        } else {
            country = countries[indexPath.row]
        }
        return country
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showDetail",
              let indexPath = tableView.indexPathForSelectedRow,
              let detailViewController = segue.destination as? CountryDetailsViewController else { return }
        
        let selectedCountry = getSelectedCountry(at: indexPath)
        
        detailViewController.country = selectedCountry
    }
        
}

extension SearchCountryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCountries.count
        }
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)

        let selectedCountry = getSelectedCountry(at: indexPath)

        cell.textLabel?.text = selectedCountry.name
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
        
}

extension SearchCountryViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchBar.text!)
    }
    
}
