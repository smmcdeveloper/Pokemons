//
//  PokemonTableViewCell.swift
//  Pokemon
//
//  Created by SMMC on 06/09/2021.
//

import UIKit
import SDWebImage

class PokemonTableViewCell: UITableViewCell {

    var safeArea: UILayoutGuide!
    
    let pokemonNameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let pokemonImageView:SDAnimatedImageView = {
        let img = SDAnimatedImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 20
        img.clipsToBounds = true
        return img
    }()
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func setupView() {
        safeArea = layoutMarginsGuide
        setupImageview()
        setupNameLabel()
    }
    
    func setupImageview() {
        addSubview(pokemonImageView)
        
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        pokemonImageView.leadingAnchor.constraint(equalTo:safeArea.leadingAnchor).isActive = true
        pokemonImageView.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
        pokemonImageView.widthAnchor.constraint(equalToConstant:40).isActive = true
        pokemonImageView.heightAnchor.constraint(equalToConstant:40).isActive = true
    }
    
    func setupNameLabel() {
        addSubview(pokemonNameLabel)
       
        pokemonNameLabel.translatesAutoresizingMaskIntoConstraints = false
        pokemonNameLabel.leadingAnchor.constraint(equalTo:pokemonImageView.trailingAnchor, constant: 10).isActive = true
        pokemonNameLabel.topAnchor.constraint(equalTo:topAnchor, constant: 5).isActive = true
    }
}
