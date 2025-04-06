//
//  CardDetailView.swift
//  Recipes
//
//  Created by Jaime Balladares on 4/4/25.
//
import SwiftUI

struct CardDetailView: View {
    let recipe: RecipeData
    
    @State private var isFavorited = false
    
    var body: some View {
        ZStack {
            //Background color
            Color.black.ignoresSafeArea(edges: .all)
            
            VStack{
                HStack {
                    //Recipe Image
                    if let urlString = recipe.photoUrlLarge,
                       let url = URL(string: urlString)
                    {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .frame(height: 600)
                                .ignoresSafeArea()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            Image(systemName: "fork.knife")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                        }
                    }
                }
                
                //Glass Card
                ZStack {
                    //Card
                    RoundedRectangle(cornerRadius: 25)
                    
                    //Recipe Name & Cusine
                    VStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("\(recipe.cuisine ?? "Unkown")")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                    .fontWeight(.regular)
                                    .padding(.horizontal, 10)
                                
                                Spacer()
                                
                                //Favorite Button
                                Button(action: {
                                    isFavorited.toggle()
                                }) {
                                    Image(systemName: isFavorited ? "heart.fill" : "heart")
                                }.font(.title)
                                    .padding(.horizontal, 15)
                            }
                            //Name
                            Text(recipe.name ?? "Unknown")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 1)
                                .padding(.horizontal, 10)
                            
                            //Placeholder description
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.black)
                                .padding(.horizontal, 10)
                            
                        }
                        
                        //External media links
                        HStack {
                            //Recipe's site will go here
                            Button { } label: {
                                Label("Read More", systemImage: "text.quote")
                            }.buttonStyle(.borderedProminent)
                            Spacer()
                            
                            //Recipe's video
                            Button { } label: {
                                Label("Video", systemImage: "video")
                            }.buttonStyle(.borderedProminent)
                        }
                        .padding(.horizontal, 25)
                        .padding(.bottom)
                    }
                }
                .opacity(0.75)
                .background(.thinMaterial)
                .frame(width: 375, height: 200)
                .cornerRadius(25)
                .padding(.bottom, 75)
            }
        }
        .padding(.bottom, 75)
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
    
    return CardDetailView(recipe: testSample)
}
