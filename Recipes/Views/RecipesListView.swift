//
//  RecipesListView.swift
//  Recipes
//
//  Created by Jaime Balladares on 4/4/25.
//
// RecipesListView.swift (with dynamic search)

import SwiftUI

struct RecipesListView: View {
    @Binding var favoriteUUIDs: Set<String>
    let recipes: [RecipeData]
    @State private var searchText: String = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredRecipes, id: \.stableID) { recipe in
                    let id = recipe.stableID

                    let isFavoritedBinding = Binding<Bool>(
                        get: { favoriteUUIDs.contains(id) },
                        set: { newValue in
                            if newValue {
                                favoriteUUIDs.insert(id)
                            } else {
                                favoriteUUIDs.remove(id)
                            }
                        }
                    )

                    NavigationLink(
                        destination: CardDetailView(
                            recipe: recipe,
                            isFavorited: isFavoritedBinding,
                            toggleFavorite: {
                                if favoriteUUIDs.contains(id) {
                                    favoriteUUIDs.remove(id)
                                } else {
                                    favoriteUUIDs.insert(id)
                                }
                            },
                            animation: nil
                        )
                    ) {
                        RecipeRow(recipe: recipe)
                    }
                }
            }
            .navigationTitle("All Recipes")
            .searchable(text: $searchText, prompt: "Search recipes by name")
        }
    }

    private var filteredRecipes: [RecipeData] {
        if searchText.isEmpty {
            return recipes
        } else {
            return recipes.filter {
                $0.name?.localizedCaseInsensitiveContains(searchText) == true
            }
        }
    }
}

// Getting the data from the API endpoint
func getRecipeData() async throws -> [RecipeData] {
    let endpoint = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"

    guard let url = URL(string: endpoint) else {
        throw URLError(.badURL)
    }

    let (data, response) = try await URLSession.shared.data(from: url)

    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        throw URLError(.badServerResponse)
    }

    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .useDefaultKeys

    let decodedResponse = try decoder.decode(RecipeWrapper.self, from: data)
    return decodedResponse.recipes
}
