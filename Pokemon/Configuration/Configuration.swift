//
//  Configuration.swift
//  Pokemon
//
//  Created by SMMC on 05/09/2021.
//

import Foundation

enum ItemsServices {
    
    private static let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    static var authenticatedBaseUrl: URL {
       return baseUrl
    }
}
 
