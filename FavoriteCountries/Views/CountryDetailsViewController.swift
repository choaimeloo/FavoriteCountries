//
//  CountryDetailsViewController.swift
//  FavoriteCountries
//
//  Created by Janiffer.Cho on 4/6/21.
//

import UIKit

class CountryDetailsViewController: UIViewController {

    let favoriteCountryManager = FavoriteCountryManager()
    var country: Country?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    private func configureViews() {
        configureLabels()
        configureDescriptionView()
        configureAddButton()
    }
    
    private func configureLabels() {
        guard let name = country?.name else { return }
        titleLabel.text = name
        subtitleLabel.text = "My favorite things about \(name):"
    }
    
    private func configureDescriptionView() {
        descriptionTextView.layer.borderColor = UIColor.darkGray.cgColor
        descriptionTextView.layer.borderWidth = 2
        descriptionTextView.layer.cornerRadius = 10
    }
    
    private func configureAddButton() {
        addButton.backgroundColor = UIColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
        addButton.layer.cornerRadius = 10
        addButton.addTarget(self, action: #selector(saveToFavorites), for: .touchUpInside)
    }
    
    @objc func saveToFavorites() {
        guard var country = country else { return }
        country.favoriteThings = descriptionTextView.text
        favoriteCountryManager.favoriteCountries.append(country)
        
        navigateHome()
    }
    
    private func navigateHome() {
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
}
