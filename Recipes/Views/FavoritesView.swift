//
//  FavoritesView.swift
//  Recipes
//
//  Created by Jaime Balladares on 4/18/25.
//

import SwiftUI

struct FavoritesView: View {
    @Binding var favoriteUUIDs: Set<String>
    let recipes: [RecipeData]

    var body: some View {
        NavigationStack {
            List {
                ForEach(favoriteRecipes(), id: \.stableID) { recipe in
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
                .onDelete { indexSet in
                    for index in indexSet {
                        let recipe = favoriteRecipes()[index]
                        favoriteUUIDs.remove(recipe.stableID)
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }

    private func favoriteRecipes() -> [RecipeData] {
        recipes.filter { favoriteUUIDs.contains($0.stableID) }
    }
}
