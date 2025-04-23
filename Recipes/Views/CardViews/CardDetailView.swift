//
//  CardDetailView.swift
//  Recipes
//
//  Created by Jaime Balladares on 4/4/25.
//
import SwiftUI

struct CardDetailView: View {
    let recipe: RecipeData
    @Binding var isFavorited: Bool
    let toggleFavorite: () -> Void
    var animation: Namespace.ID? = nil

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let url = URL(string: recipe.photoUrlLarge ?? "") {
                    AsyncImage(url: url) { image in
                        Group {
                            if let animation {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .matchedGeometryEffect(id: recipe.uuid ?? UUID().uuidString, in: animation)
                            } else {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            }
                        }
                        .frame(height: 400)
                        .clipped()
                    } placeholder: {
                        Color.gray.opacity(0.2)
                            .frame(height: 400)
                    }
                }

                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(recipe.name ?? "Unknown")
                            .font(.largeTitle.bold())
                        Text(recipe.cuisine ?? "")
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }

                    Spacer()

                    Button(action: {
                        withAnimation {
                            toggleFavorite()
                        }
                    }) {
                        Image(systemName: isFavorited ? "heart.fill" : "heart")
                            .font(.title2)
                            .foregroundColor(isFavorited ? .red : .gray)
                    }
                }
                .padding(.horizontal)

                Text("Description")
                    .font(.title2.weight(.medium))
                    .padding(.horizontal)

                Text("Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)

                HStack(spacing: 16) {
                    if let url = URL(string: recipe.sourceUrl ?? "") {
                        Link(destination: url) {
                            Label("Read More", systemImage: "book")
                        }
                    }

                    if let url = URL(string: recipe.youtubeUrl ?? "") {
                        Link(destination: url) {
                            Label("Watch Video", systemImage: "play.circle")
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .background(.ultraThickMaterial)
    }
}


