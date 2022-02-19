//
//  CommonView.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 18.02.2022.
//

import UIKit

class CommonView: UIView {
    
    enum Presentation {
        case emptyResult, error
    }
    
    private let width: CGFloat = 300
    
    private let presentation: Presentation
    
    init(frame: CGRect = .zero, presentation: Presentation) {
        self.presentation = presentation
        super.init(frame: frame)
        
        configurePresentation()
        addSubview(imageView)
        setupConstraintsForImageView()
        
        addSubview(descriptionLabel)
        setupConstraintsForLabel()
    }
    
    required init ?(coder aDecoder: NSCoder) {
        self.presentation = .error
        super.init(coder: aDecoder)
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont(name: "Avenir-Heavy", size: 20)
        label.textColor = .darkGray
        return label
    }()
    
    private func setupConstraintsForImageView() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: width),
            imageView.heightAnchor.constraint(equalToConstant: width)
        ])
    }
    
    private func setupConstraintsForLabel() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalToConstant: width),
            descriptionLabel.heightAnchor.constraint(equalToConstant: width)
        ])
    }
    
    func configurePresentation() {
        
        switch presentation {
            
        case .emptyResult:
            imageView.image = UIImage(systemName: "magnifyingglass")
            descriptionLabel.text = "Nothing found"
            
        case .error:
            imageView.image = UIImage(systemName: "network")
            descriptionLabel.text = "Something went wrong"
        }
    }
}
