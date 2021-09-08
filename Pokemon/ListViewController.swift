//
//  ListViewController.swift
//  Pokemon
//
//  Created by SMMC on 05/09/2021.
//

import UIKit
import SDWebImage

class ListViewController: UIViewController {
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    var itemsListViewModel = ItemsListViewModel()
    var pokemonList = [PokemonResponse]()
    var pokemonPhotos = [String]()
    
   // MARK: - View Life Cycle
   override func viewDidLoad() {
        super.viewDidLoad()
      
        setupView()
        setupTableView()
        
        itemsListViewModel.fetchPokemonsList { pokemonList in
            DispatchQueue.main.async {
                self.pokemonList = pokemonList
                self.tableView.reloadData()
            }
        }
        itemsListViewModel.fetchPokemonPhotos { pokemonPhotos in
            DispatchQueue.main.async {
                self.pokemonPhotos = pokemonPhotos
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Private Methods
    func setupView() {
        self.navigationItem.title = "Pokemons"
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
    }
 
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: "customCell")
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if !pokemonList.isEmpty && !pokemonPhotos.isEmpty {
        return self.pokemonList[0].results.count
    }
    
    return 0
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! PokemonTableViewCell
    cell.pokemonNameLabel.text = self.pokemonList[0].results[indexPath.row].name ?? ""
    
    let pokemonPhotoUrl = self.pokemonPhotos[indexPath.row]
    cell.pokemonImageView.sd_setImage(with: URL(string:pokemonPhotoUrl), placeholderImage: UIImage(named: "placeholder.png"))
   
    return cell
  }
    
  func tableView(_ tableView: UITableView, didSelectRowAt: IndexPath) {
    
    guard let pokemonUrl = self.pokemonList[0].results[didSelectRowAt.row].url else { return }
    
    itemsListViewModel.fetchPokemonDetails(url:pokemonUrl) { pokemonDetails in
        DispatchQueue.main.async {
            let detailObjectiveCViewController = DetailsViewController()
            
            detailObjectiveCViewController.name = self.pokemonList[0].results[didSelectRowAt.row].name ?? ""
            detailObjectiveCViewController.imageUrl = self.pokemonPhotos[didSelectRowAt.row]
            
            //print("pokemonTypes",self.itemsListViewModel.getPokemonTypes(detailsPokemon: pokemonDetails))
            detailObjectiveCViewController.types = (pokemonDetails.types as? [Any])!
            detailObjectiveCViewController.stats = (pokemonDetails.stats as? [Any])! 
                   
            self.navigationController?.pushViewController(detailObjectiveCViewController, animated: true)
        }
    }
  }
    
}

