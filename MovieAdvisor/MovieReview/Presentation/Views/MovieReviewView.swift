//
//  MovieReviewView.swift
//  MovieAdvisor
//
//  Created by Анастасия Шепурева on 17.02.2022.
//

import UIKit
import SDWebImage

class MovieReviewView: UIView {
    
    class InfoLabel: UILabel {
        override init(frame: CGRect) {
            super.init(frame: frame)
            textColor = .darkGray
            textAlignment = .left
            font = UIFont(name: "Avenir", size: 14)
            translatesAutoresizingMaskIntoConstraints = false
        }
        
        required init ?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
        }
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Heavy", size: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Heavy", size: 18)
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingLabel = InfoLabel()
    private lazy var genreLabel = InfoLabel()
    private lazy var budgetLabel = InfoLabel()
    private lazy var revenueLabel = InfoLabel()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [genreLabel, ratingLabel, budgetLabel, revenueLabel])
        stackView.contentMode = .scaleAspectFit
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var errorView: CommonView = {
        let view = CommonView(presentation: .error)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var emptyResultView: CommonView = {
        let view = CommonView(presentation: .emptyResult)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(scrollView)
        setupConstraintsForScrollView()
        
        scrollView.addSubview(posterImageView)
        setupConstraintsForPosterImage()
        
        scrollView.addSubview(titleLabel)
        setupConstraintsForTitleLabel()
        
        scrollView.addSubview(overviewLabel)
        setupConstraintsForOverviewLabel()

        scrollView.addSubview(stackView)
        setupConstraintsForStackView()
        
    }
    
    required init ?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    private func setupConstraintsForScrollView() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupConstraintsForPosterImage() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2)
        ])
    }
    
    private func setupConstraintsForTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupConstraintsForOverviewLabel() {
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            overviewLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            overviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    private func setupConstraintsForStackView() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupConstraintsForCommonView(_ view: CommonView) {
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func updateUI(_ model: MovieReviewViewModel) {
        posterImageView.sd_setImage(with: model.image)
        titleLabel.text = model.title
        overviewLabel.text = model.overview
        genreLabel.text = model.genres
        revenueLabel.text = "Revenue: " + model.revenue
        budgetLabel.text = "Budget: " + model.budget
        ratingLabel.text = "Rating: " + model.rating
    }
    
    func showEmptyView() {
        scrollView.isHidden = true
        addSubview(emptyResultView)
        setupConstraintsForCommonView(emptyResultView)
    }
    
    func showErrorView() {
        scrollView.isHidden = true
        addSubview(errorView)
        setupConstraintsForCommonView(errorView)
    }
}
