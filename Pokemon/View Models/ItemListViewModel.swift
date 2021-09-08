//
//  ItemListViewModel.swift
//  Pokemon
//
//  Created by SMMC on 05/09/2021.
//

import Foundation

class ItemsListViewModel {
    
    func fetchPokemonsList(completionBlock: @escaping ([PokemonResponse])->()) {
        
        let itemsRequest = PokemonRequest(baseUrl: ItemsServices.authenticatedBaseUrl)
        
        guard let url = URL(string: itemsRequest.url) else { return }
       
         let task = URLSession.shared.dataTask(with: url) { data, response, error in
                   guard error == nil else {
                      print(error?.localizedDescription as Any)
                      return
                   }

                   guard
                       let httpResponse = response as? HTTPURLResponse,
                       200 ..< 300 ~= httpResponse.statusCode else {
                         print("Invalind Response")
                       return
                   }
            do {
                let result = try JSONDecoder().decode(PokemonResponse.self, from: data!)
                completionBlock([result])
                
            } catch let jsonErr {
                print("Error serializing inner JSON:", jsonErr)
            }
        }
        
        task.resume()
        
    }
    
    func fetchPokemonPhotos(completionBlock: @escaping ([String])->()) {
      
        let itemsRequest = PokemonRequest(baseUrl: ItemsServices.authenticatedBaseUrl)
        
        guard let url = URL(string: itemsRequest.url) else { return }
        
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
           
            do {
                let pokedex = try JSONDecoder().decode(PokemonResponse.self, from: data)
                let pokemonsCount = pokedex.results.count
                var pokemonPhotos = [String]()
                var counter = 1
                
                for pokemon in pokedex.results {
                    
                   guard let jsonURL = pokemon.url else { return }
                   guard let newURL = URL(string: jsonURL) else { return }
                      
                   URLSession.shared.dataTask(with: newURL) {(data, response, error) in
                        guard let data = data else { return }
                        do {
                            let load = try JSONDecoder().decode(PokemonPhotos.self, from: data)
                            pokemonPhotos.append(load.sprites?.front_default ?? "")
                           
                            if ( pokemonsCount == counter) {
                                completionBlock(pokemonPhotos)
                            }
                            counter += 1
                           
                        } catch let jsonErr {
                            print("Error serializing inner JSON:", jsonErr)
                        }
                    
                      
                    }.resume()
                }
              
            } catch let jsonErr{
                print("Error serializing JSON: ", jsonErr)
            }
        }.resume()

    }

    
    func fetchPokemonDetails(url:String, completionBlock: @escaping (Pokemon)->()) {
      
        guard let newURL = URL(string: url) else { return }

        let task = URLSession.shared.dataTask(with: newURL) {(data, response, error) in
            guard error == nil else {
               print(error?.localizedDescription as Any)
               return
            }

            guard
                let httpResponse = response as? HTTPURLResponse,
                200 ..< 300 ~= httpResponse.statusCode else {
                  print("Invalind Response")
                  return
            }
            
            guard let data = data else { return }
            do {
                  let pokemonDetails = try JSONDecoder().decode(Pokemon.self, from: data)
                  completionBlock(pokemonDetails)
                
                } catch let jsonErr {
                  print("Error serializing inner JSON:", jsonErr)
                }
            }
        
            task.resume()
    }
}

