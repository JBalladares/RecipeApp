//
//  RecipeData.swift
//  Recipes
//
//  Created by Jaime Balladares on 4/4/25.
//
import Foundation

struct RecipeData: Codable {
    let cuisine: String?
    let name: String?
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let uuid: String?
    let sourceUrl: String?
    let youtubeUrl: String?
    
//converting to use throughout our codebase
    enum CodingKeys: String, CodingKey {
        case cuisine, name, uuid
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }
}

struct RecipeWrapper: Codable {
    let recipes: [RecipeData]
}

extension RecipeData {
    var stableID: String {
        uuid ?? name ?? "unknown-\(photoUrlLarge ?? "")"
    }
}
