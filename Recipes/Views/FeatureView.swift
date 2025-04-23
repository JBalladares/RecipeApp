//
//  HomeView.swift
//  Recipes
//
//  Created by Jaime Balladares on 4/5/25.
//
import SwiftUI

struct FeatureView: View {
    @Binding var favoriteUUIDs: Set<String>
    let recipes: [RecipeData]
    @Namespace private var animation
    let refresh: () async -> Void

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Top Picks")
                        .font(.largeTitle.bold())
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 32) {
                            ForEach(recipes.prefix(6), id: \.stableID) { recipe in
                                makePreviewCard(for: recipe, overlayText: true)
                            }
                        }
                        .padding(.horizontal)
                    }

                    Text("Recommended")
                        .font(.title2.weight(.medium))
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(recommendedRecipes(), id: \.stableID) { recipe in
                                VStack(alignment: .leading, spacing: 4) {
                                    makePreviewCard(for: recipe, overlayText: false, width: 170, height: 200)
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(recipe.name ?? "Unknown")
                                            .font(.subheadline)
                                            .foregroundColor(.primary)
                                            .lineLimit(1)
                                            .truncationMode(.tail)
                                        Text(recipe.cuisine ?? "")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    .padding([.horizontal, .bottom], 8)
                                }
                                .frame(width: 170)
                                .background(Color(.systemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 16))
//                                .shadow(radius: 4)
                            }
                        }
                        .scrollTargetLayout()
                        .padding(.horizontal)
                    }
                    .scrollTargetBehavior(.viewAligned)

                    ForEach(uniqueCuisines().prefix(3), id: \.self) { cuisine in
                        VStack(alignment: .leading) {
                            Text(cuisine)
                                .font(.title3.bold())
                                .padding(.horizontal)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(recipesForCuisine(cuisine), id: \.stableID) { recipe in
                                        VStack(alignment: .leading, spacing: 4) {
                                            makePreviewCard(for: recipe, overlayText: false, width: 170, height: 200)
                                            VStack(alignment: .leading, spacing: 2) {
                                                Text(recipe.name ?? "Unknown")
                                                    .font(.subheadline)
                                                    .foregroundColor(.primary)
                                                    .lineLimit(1)
                                                    .truncationMode(.tail)
                                                Text(recipe.cuisine ?? "")
                                                    .font(.caption)
                                                    .foregroundColor(.secondary)
                                            }
                                            .padding([.horizontal, .bottom], 8)
                                        }
                                        .frame(width: 170)
                                        .background(Color(.systemBackground))
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
//                                        .shadow(radius: 4)
                                    }
                                }
                                .scrollTargetLayout()
                                .padding(.horizontal)
                            }
                            .scrollTargetBehavior(.viewAligned)
                        }
                    }
                }
                .padding(.top)
            }
            .refreshable {
                await refresh()
            }
            .background(.ultraThinMaterial)
            .navigationTitle("Recipes")
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }

    @ViewBuilder
    private func makePreviewCard(for recipe: RecipeData, overlayText: Bool, width: CGFloat = 250, height: CGFloat = 300) -> some View {
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
                toggleFavorite: { toggleFavorite(for: recipe) },
                animation: animation
            )
        ) {
            ZStack(alignment: .bottomLeading) {
                PreviewCardView(
                    recipe: recipe,
                    isFavorited: favoriteUUIDs.contains(recipe.stableID),
                    animation: animation
                )
                .frame(width: width, height: height)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                if overlayText {
                    LinearGradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.8)], startPoint: .center, endPoint: .bottom)
                        .clipShape(RoundedRectangle(cornerRadius: 20))

                    VStack(alignment: .leading, spacing: 4) {
                        Text(recipe.name ?? "Unknown")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(recipe.cuisine ?? "")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.85))
                    }
                    .padding()
                }
            }
        }
    }

    private func toggleFavorite(for recipe: RecipeData) {
        let id = recipe.stableID
        if favoriteUUIDs.contains(id) {
            favoriteUUIDs.remove(id)
        } else {
            favoriteUUIDs.insert(id)
        }
    }

    private func recommendedRecipes() -> [RecipeData] {
        Array(recipes.shuffled().prefix(5))
    }

    private func uniqueCuisines() -> [String] {
        let cuisines = recipes.compactMap { $0.cuisine }
        return Array(Set(cuisines)).sorted()
    }

    private func recipesForCuisine(_ cuisine: String) -> [RecipeData] {
        recipes.filter { $0.cuisine == cuisine }
    }
}
