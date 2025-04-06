//
//  RecipesListView.swift
//  Recipes
//
//  Created by Jaime Balladares on 4/4/25.
//

import SwiftUI

struct RecipesListView: View {
    @State private var recipes = [RecipeData]()
    
    var body: some View {
        NavigationView {
            //get the names of all the recipes
            List(recipes, id: \.name) { recipe in
                //lazy HStack so we don't need to force load everything at once
                LazyHStack {
                    //get the small images
                    if let urlString = recipe.photoUrlSmall,
                       let url = URL(string: urlString)
                    {
                        //Image
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        } placeholder: {
                            Image(systemName: "fork.knife.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                        }
                    }
                    //linking to CardDetailView
                    NavigationLink(destination: CardDetailView(recipe: recipe)) {
                        Text(recipe.name ?? "Unknown")
                    }
                }
            }
            .navigationTitle(Text("All Recipes"))
            //getting our recipe data
            .task {
                do {
                    recipes = try await getRecipeData()
                } catch {
                    print("Failed to fetch")
                    print("Error: \(error)")
                    print("Error Type: \(type(of: error))")
                }
            }
        }
    }
}

//getting the data from the API endpoint
func getRecipeData() async throws -> [RecipeData] {
    let endpoint = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    
    guard let url = URL(string: endpoint) else {
        throw URLError(.badURL)
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    //handle any errors when fetching
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
        throw URLError(.badServerResponse)
    }
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .useDefaultKeys
    
    let decodedResponse = try decoder.decode(RecipeWrapper.self, from: data)
    return decodedResponse.recipes
}



#Preview {
    RecipesListView()
}
