//
//  HomeView.swift
//  Recipes
//
//  Created by Jaime Balladares on 4/5/25.
//

import SwiftUI

struct FeatureView: View {
    @State private var recipes = [RecipeData]()
    
    var body: some View {
            VStack{
                HStack {
                    //Feature Title. Can create more using template.
                    Text("For You")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                }.padding(.top, 25)
                
                //Making the list scrollable
                ScrollView(.horizontal, showsIndicators: true) {
                    LazyHStack{
                        ForEach(recipes.prefix(5), id: \.name) { recipe in
                            PreviewCardView(recipe: recipe)
                        }.padding(.horizontal)
                    }
                    .scrollTargetBehavior(.paging)
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
    FeatureView()
}
