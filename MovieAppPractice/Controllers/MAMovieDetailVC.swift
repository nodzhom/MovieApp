//
//  MAMovieDetalVC.swift
//  MovieAppPractice
//
//  Created by Onur Com on 21.04.2020.
//  Copyright © 2020 Onur Com. All rights reserved.
//

import UIKit

class MAMovieDetailVC: UIViewController {
    
    let moviePoster = MAImageView(frame: .zero)
    let detailsCard = UIView()
    let favButton = MAFavoriteButton()
    let movieName = MATitleLabel()
    let infoStackView = UIStackView()
    let movieDateLabel = MABodyLabel()
    let genreLabel = MABodyLabel()
    let durationLabel = MABodyLabel()
    let ratingStarImageView = UIImageView()
    let ratingLabel = MABodyLabel()
    let overviewTitleLabel = MATitleLabel()
    let overviewLabel = MABodyLabel()
    let dateFormatter = DateFormatter()
    
    
    var movie: Movie!
    

    init(movie: Movie) {
        super.init(nibName: nil, bundle: nil)
        self.movie = movie
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        configureBackgroundView()
        configureDetailsCard()
        configurefavButton()
        configureMoviePoster()
        configureMovieName()
        configureStackView()
        configureOverview()
        layoutUI()

    }
    
    private func configurefavButton() {
        favButton.addTarget(self, action: #selector(favButtonTapped), for: .touchUpInside)

    }
    
    @objc func favButtonTapped() {
        
        PersistenceManager.updateWith(favorite: movie, actionType: .add) { [weak self] error in
            guard let self = self else { return
            }
            guard let error = error else {
                self.favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                self.favButton.tintColor = .systemRed
                return
            }
            self.presentMAAlertOnMainThread(title: "Cant add to Favorites", message: "You have already added this movie to your favorites", buttonTitle: "Ok")
        }
     
    }
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 10
        view.backgroundColor    = .secondarySystemBackground
    }
    
    private func configureMoviePoster() {
        moviePoster.downloadImage(fromURL: "https://image.tmdb.org/t/p/w780/" + movie.poster_path)
    }
    

    private func configureMovieName() {
        movieName.text = movie.title
        movieName.font = UIFont(name: "Helvetica-Light", size: 25)
        movieName.numberOfLines = 0
        movieName.textAlignment = .center
    }
    
    private func configureDetailsCard() {
        detailsCard.layer.cornerRadius = 10
        detailsCard.backgroundColor    = .secondarySystemBackground
    }
    
    private func configureStackView() {

        var releaseDate = movie.release_date
        releaseDate = String(releaseDate.prefix(4))
        movieDateLabel.text = releaseDate
        
        //TODO: dont forget to handle genre ids
        genreLabel.text = "Action, Thriller"
        durationLabel.text = "2h 17m"
        ratingStarImageView.image = UIImage(systemName: "star.fill")
        ratingStarImageView.tintColor = .systemPurple
        ratingStarImageView.contentMode = .scaleAspectFit
        ratingLabel.text = String(movie.vote_average)
        
        infoStackView.axis          = .horizontal
        infoStackView.distribution  = .equalSpacing
        infoStackView.spacing       = 10
        
        infoStackView.addArrangedSubview(movieDateLabel)
        infoStackView.addArrangedSubview(genreLabel)
        infoStackView.addArrangedSubview(durationLabel)
        infoStackView.addArrangedSubview(ratingStarImageView)
        infoStackView.addArrangedSubview(ratingLabel)
    }
    
    private func configureOverview() {
        overviewTitleLabel.text = "Overview"
        overviewLabel.text = movie.overview
        overviewLabel.numberOfLines = 0
    }
    
    private func layoutUI() {
        view.addSubview(moviePoster)
        view.addSubview(detailsCard)
        detailsCard.addSubview(favButton)
        detailsCard.addSubview(movieName)
        detailsCard.addSubview(infoStackView)
        detailsCard.addSubview(overviewTitleLabel)
        detailsCard.addSubview(overviewLabel)
        
        moviePoster.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        detailsCard.translatesAutoresizingMaskIntoConstraints = false
        overviewTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            moviePoster.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviePoster.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviePoster.topAnchor.constraint(equalTo: view.topAnchor),
            moviePoster.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            detailsCard.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailsCard.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailsCard.topAnchor.constraint(equalTo: moviePoster.topAnchor, constant: 300),
            detailsCard.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            favButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            favButton.topAnchor.constraint(equalTo: detailsCard.topAnchor, constant: 10),
            favButton.widthAnchor.constraint(equalToConstant: 30),
            favButton.heightAnchor.constraint(equalToConstant: 30),
            
            movieName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            movieName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            movieName.topAnchor.constraint(equalTo: detailsCard.topAnchor),
            movieName.heightAnchor.constraint(equalToConstant: 85),
            
            infoStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoStackView.topAnchor.constraint(equalTo: movieName.bottomAnchor),
            infoStackView.heightAnchor.constraint(equalToConstant: 20),
            
            overviewTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            overviewTitleLabel.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 15),
            
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            overviewLabel.topAnchor.constraint(equalTo: overviewTitleLabel.bottomAnchor, constant: 10),
            
        ])
        
    }

}
