//
//  ViewController.swift
//  FavoriteCountries
//
//  Created by Janiffer.Cho on 4/6/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    let addCountryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitle("Add Country", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(addCountryTapped), for: .touchUpInside)
        return button
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(FavoriteCountryCell.self, forCellWithReuseIdentifier: FavoriteCountryCell.identifier)
        cv.backgroundColor = .white
        return cv
    }()
    
    let favoriteCountryManager = FavoriteCountryManager()
    var favoriteCountries: [Country] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteCountries = favoriteCountryManager.favoriteCountries
        
        configureNavigationBar()
        configureViews()
        configureFlowLayout()
    }
        
    private func configureNavigationBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadData))
        navigationItem.title = "My Favorite Countries"
        navigationItem.setHidesBackButton(true, animated: true)
    }
        
    private func configureViews() {
        configureMainView()
        configureAddCountryButton()
        configureCollectionView()
    }
        
    private func configureFlowLayout() {
        let layout = collectionView.collectionViewLayout
        if let flowLayout = layout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: collectionView.widestCellWidth, height: 200)
        }
    }
    
    private func configureMainView() {
        view.backgroundColor = .white
    }
    
    private func configureAddCountryButton() {
        view.addSubview(addCountryButton)
        NSLayoutConstraint.activate([
            addCountryButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            addCountryButton.heightAnchor.constraint(equalToConstant: 40),
            addCountryButton.widthAnchor.constraint(equalToConstant: 200),
            addCountryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: addCountryButton.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - IBActions
    @objc func addCountryTapped() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "showSearch", sender: nil)
        }
    }
    
    @objc func reloadData() {
        favoriteCountryManager.loadJSONFavoriteCountries()
        favoriteCountries = favoriteCountryManager.favoriteCountries
        collectionView.reloadData()
    }
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteCountries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCountryCell.identifier, for: indexPath) as! FavoriteCountryCell
        cell.titleLabel.text = favoriteCountries[indexPath.item].name
        cell.detailLabel.text = favoriteCountries[indexPath.item].favoriteThings
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

}

extension UICollectionView {
    
    var widestCellWidth: CGFloat {
        let insets = contentInset.left + contentInset.right
        return bounds.width - insets
    }
    
}
