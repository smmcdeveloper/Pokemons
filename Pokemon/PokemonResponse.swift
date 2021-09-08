//
//  Pokemon.swift
//  Pokemon
//
//  Created by SMMC on 06/09/2021.
//

import Foundation

struct PokemonResponse: Decodable {
    let count: Int?
    let results: [Results]
}

struct Results: Decodable {
    let name: String?
    let url: String?
}

struct PokemonPhotos: Decodable {
    let sprites: Sprite?
}

struct Pokemon: Decodable {
    let stats: [Stats]?
    let types: [Type]?
    let sprites: Sprite?
}

struct Sprite: Decodable {
    let front_default: String?
}

struct Stats: Decodable {
    let stat: statDic?
}

struct statDic: Decodable {
    let name: String?
}

struct Type: Decodable {
    let type: typeDic?
}

struct typeDic: Decodable {
    let name: String?
}
