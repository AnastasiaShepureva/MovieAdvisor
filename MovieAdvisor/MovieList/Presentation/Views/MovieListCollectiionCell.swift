//
//  MovieListCollectiionCell.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 16.02.2022.
//

import UIKit
import SDWebImage

class MovieListCollectiionCell: UICollectionViewCell {
    
    private lazy var side: CGFloat = 65
    
    private lazy var previewImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLable: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.font = UIFont(name: "Avenir", size: 17)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont(name: "Avenir-Heavy", size: 17)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init ?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        previewImage.image = nil
        titleLable.text = nil
        ratingLabel.text = nil
    }
    
    private func setupViews() {
        
        contentView.addSubview(previewImage)
        setupConstraintsForPreviewImage()
        
        contentView.addSubview(titleLable)
        setupConstraintsForTitleLable()
        
        contentView.addSubview(ratingLabel)
        setupConstraintsForRatingLable()
        
    }
    
    private func setupConstraintsForPreviewImage() {
        NSLayoutConstraint.activate([
            previewImage.heightAnchor.constraint(equalToConstant: side),
            previewImage.widthAnchor.constraint(equalToConstant: side),
            previewImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            previewImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7)
        ])
    }
    
    private func setupConstraintsForTitleLable() {
        NSLayoutConstraint.activate([
            titleLable.leadingAnchor.constraint(equalTo: previewImage.trailingAnchor, constant: 7),
            titleLable.heightAnchor.constraint(equalToConstant: side),
            titleLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -side),
            titleLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    private func setupConstraintsForRatingLable() {
        NSLayoutConstraint.activate([
            ratingLabel.leadingAnchor.constraint(equalTo: titleLable.trailingAnchor),
            ratingLabel.heightAnchor.constraint(equalToConstant: side),
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7),
            ratingLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    func configureCell(_ model: MovieListViewModel) {
        titleLable.text = model.title
        ratingLabel.text = model.rating
        previewImage.sd_setImage(with: model.imageUrl)
    }
}
