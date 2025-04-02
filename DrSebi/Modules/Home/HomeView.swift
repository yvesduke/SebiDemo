//
//  HomeView.swift
//  DrSebi
//
//  Created by Yves Dukuze on 18/10/2023.
//

import UIKit

class HomeView: UIView {
        
    
    lazy var welcomeTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Coloring.color_1.rawValue
        label.text = NSLocalizedString("Welcome_Title", comment: "")
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var moreDetailsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "More details"
        label.textColor = UIColor(red: 0.15, green: 0.66, blue: 0.18, alpha: 1.00)
      return label
    }()
    
     lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("Subtitle", comment: "")
        label.textColor = .lightGray
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = .zero
        label.backgroundColor = UIColor(red: 0.18, green: 0.60, blue: 0.30, alpha: 0.07)
      return label
    }()
    
     lazy var imageTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("Image_Title", comment: "")
        label.textColor = UIColor(red: 0.15, green: 0.66, blue: 0.18, alpha: 1.00)
      return label
    }()
    

    
    private lazy var welcomeImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill

        image.clipsToBounds = true
        image.backgroundColor = .green
        image.layer.cornerRadius = 8
        image.image = UIImage(named: "6")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupViews() {
        addSubviews(welcomeTitleLabel, moreDetailsLabel, subTitleLabel, imageTitleLabel, welcomeImageView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            welcomeTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 60),
            welcomeTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6),
            welcomeTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2),
        ])
        
        NSLayoutConstraint.activate([
            moreDetailsLabel.topAnchor.constraint(equalTo: welcomeTitleLabel.bottomAnchor, constant: 0),
            moreDetailsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Spacing.space_lg.rawValue),
            moreDetailsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Spacing.space_lg.rawValue)
        ])
        
        NSLayoutConstraint.activate([
            subTitleLabel.topAnchor.constraint(equalTo: moreDetailsLabel.bottomAnchor, constant: Spacing.space_lg.rawValue),
            subTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
            subTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6),
        ])
        
        NSLayoutConstraint.activate([
            imageTitleLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: Spacing.space_lg.rawValue),
            imageTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Spacing.space_lg.rawValue),
            imageTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Spacing.space_lg.rawValue)
        ])
        
        NSLayoutConstraint.activate([
            welcomeImageView.topAnchor.constraint(equalTo: imageTitleLabel.bottomAnchor, constant: Spacing.space_lg.rawValue),
            welcomeImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Spacing.space_lg.rawValue),
            welcomeImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Spacing.space_lg.rawValue),
            welcomeImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        imageTitleLabel.setContentHuggingPriority(.init(rawValue: 252), for: .vertical)
        imageTitleLabel.setContentCompressionResistancePriority(.init(rawValue: 751), for: .vertical)
    }
    
}
