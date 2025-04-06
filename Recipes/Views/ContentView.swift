//
//  ContentView.swift
//  Recipes
//
//  Created by Jaime Balladares on 4/4/25.
//
import SwiftUI

struct ContentView: View {
    @State private var recipes = [RecipeData]()
    
    var body: some View {
        TabView {
            //Main Home View
            FeatureView().tabItem {
                Label("Home", systemImage: "house")
            }
            
            //Scan Feature View
            CameraScanView().tabItem {
                Label("Scan", systemImage: "camera")
            }
            
            //List Tab View
            RecipesListView().tabItem {
                Label("Recipes", systemImage: "list.bullet")
            }
        }
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




#Preview {
    ContentView()
}
