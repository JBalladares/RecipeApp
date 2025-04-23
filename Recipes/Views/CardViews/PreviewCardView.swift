//
//  PreviewCardView.swift
//  Recipes
//
//  Created by Jaime Balladares on 4/5/25.
//
import SwiftUI

struct PreviewCardView: View {
    let recipe: RecipeData
    let isFavorited: Bool
    var animation: Namespace.ID

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let url = URL(string: recipe.photoUrlLarge ?? "") {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .matchedGeometryEffect(id: recipe.uuid ?? UUID().uuidString, in: animation)
                } placeholder: {
                    Color.gray.opacity(0.2)
                }
            }
        }
        .frame(width: 250, height: 300)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
    }
}

struct RecipeRow: View {
    let recipe: RecipeData

    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: recipe.photoUrlSmall ?? "")) { image in
                image.resizable().aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray.opacity(0.2)
            }
            .frame(width: 60, height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name ?? "Unknown")
                    .font(.headline)
                Text(recipe.cuisine ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

