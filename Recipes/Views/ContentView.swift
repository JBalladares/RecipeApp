//
//  ContentView.swift
//  Recipes
//
//  Created by Jaime Balladares on 4/4/25.
//
import SwiftUI

struct ContentView: View {
    @State private var recipes: [RecipeData] = []
    @State private var favoriteUUIDs: Set<String> = []

    var body: some View {
        TabView {
               FeatureView(favoriteUUIDs: $favoriteUUIDs, recipes: recipes,     refresh: {
                   do {
                       recipes = try await getRecipeData()
                   } catch {
                       print("Error refreshing: \(error)")
                   }
               })
                   .tabItem {
                       Label("Home", systemImage: "house")
                   }

               RecipesListView(favoriteUUIDs: $favoriteUUIDs, recipes: recipes)
                   .tabItem {
                       Label("Recipes", systemImage: "list.bullet")
                   }

               FavoritesView(favoriteUUIDs: $favoriteUUIDs, recipes: recipes)
                   .tabItem {
                       Label("Favorites", systemImage: "heart.fill")
                   }
           }
        //getting our recipe data
        .task {
            do {
                recipes = try await getRecipeData()
            } catch {
                print("Error loading recipes: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
