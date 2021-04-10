//
//  FavoriteCountryCell.swift
//  FavoriteCountries
//
//  Created by Janiffer.Cho on 4/6/21.
//

import UIKit

class FavoriteCountryCell: UICollectionViewCell {
    
    static let identifier = "FavoriteCountryCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Country"
        label.textColor = .black
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Details"
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        view.backgroundColor = .lightGray
        return view
    }()
        
    private func configureViews() {
        configureMainView()
        configureTitleLabel()
        configureDetailLabel()
        configureSeparatorView()
    }
    
    private func configureMainView() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTitleLabel() {
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
        ])
    }
    
    private func configureDetailLabel() {
        contentView.addSubview(detailLabel)
        NSLayoutConstraint.activate([
            detailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            detailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            detailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func configureSeparatorView() {
        contentView.addSubview(separatorView)
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            separatorView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10)
        ])
    }
        
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        var targetSize = targetSize
        targetSize.height = CGFloat.greatestFiniteMagnitude
        let size = super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return size
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViews()
    }
    
}
