//
//  PopularMoviesCell.swift
//  mobileTMDB(version 2.0)
//
//  Created by rushan adelshin on 08.12.2018.
//  Copyright © 2018 Eldar Adelshin. All rights reserved.
//

import UIKit

class PopularMoviesCell: UITableViewCell {

    var movieTitleLabel: UILabel!
    var movieGenres: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeSubviews() {
        movieTitleLabel = UILabel()
        movieTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        movieTitleLabel.textColor = UIColor(white: 0.3, alpha: 1.0)
        movieTitleLabel.numberOfLines = 1
        
        movieGenres = UILabel()
        movieGenres.font = UIFont.systemFont(ofSize: 14)
        movieGenres.textColor = UIColor(white: 0.6, alpha: 1.0)
        movieGenres.numberOfLines = 1
        
        let stack = UIStackView(arrangedSubviews: [movieTitleLabel, movieGenres])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .equalCentering
        
        let horizontalStack = UIStackView(arrangedSubviews: [stack])
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fill
        horizontalStack.alignment = .center
        
        contentView.addSubview(horizontalStack)
        
        NSLayoutConstraint.activate([
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            ])
        
        
    }
    
}
