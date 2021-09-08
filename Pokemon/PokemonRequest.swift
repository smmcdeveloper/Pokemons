//
//  PokemonRequest.swift
//  Pokemon
//
//  Created by SMMC on 06/09/2021.
//

import Foundation

struct PokemonRequest {
    
    let baseUrl: URL
    
    var url: String {
        return "https://pokeapi.co/api/v2/pokemon/"
    }
}
