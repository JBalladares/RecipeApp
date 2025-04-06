//
//  PreviewCardView.swift
//  Recipes
//
//  Created by Jaime Balladares on 4/5/25.
//

import SwiftUI

struct PreviewCardView: View {
    let recipe: RecipeData
    @State private var isFavorited = false
    
    var body: some View {
        ZStack {
            //background of the card
            RoundedRectangle(cornerRadius: 25)
                .border(.white, width: 1)
                .cornerRadius(25)
                .shadow(color: .white, radius: 5)
                .opacity(0.75)
            
            ZStack {
                VStack {
                    ZStack {
                        //Title Card Layout
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(.black)
                            .frame(width: 325)
                            .padding(.top)
                        
                        //Name/Cusine & Favorite Button
                        VStack(alignment: .leading) {
                            HStack {
                                //Cusine name
                                Text("\(recipe.cuisine ?? "Unkown")")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .fontWeight(.regular)
                                
                                Spacer()
                                
                                //Favorite Button
                                Button(action: {
                                    isFavorited.toggle()
                                }) {
                                    Image(systemName: isFavorited ? "heart.fill" : "heart")
                                }.font(.title)
                                
                            }
                            //Name
                            Text(recipe.name ?? "Unknown")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .padding(.all, 50)
                    }
                    
                    //Recipe Image
                    if let urlString = recipe.photoUrlLarge,
                       let url = URL(string: urlString)
                    {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .ignoresSafeArea()
                                .frame(height: 350)
                                .cornerRadius(25)
                        } placeholder: {
                            Image(systemName: "fork.knife")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                        }
                    }
                }
            }
            
        }
        .frame(width: 300, height: 500)
        .padding(.horizontal)
    }
}

#Preview {
    let testSample = RecipeData(
        cuisine: "Malaysian",
        name: "Apam Balik",
        photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
        photoUrlSmall: "https://example.com/image.jpg",
        uuid: "12345",
        sourceUrl: "https://example.com",
        youtubeUrl: "https://youtube.com"
    )
    
    return PreviewCardView(recipe: testSample)
}
