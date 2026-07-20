//
//  RecipeDetailView.swift
//  RecipeV1
//
//  Created by Chris Maker on 20/7/2026.
//

import SwiftUI

struct RecipeDetailView: View {
    let documentID: String
    let recipe: Recipe

    var body: some View {
        List {
            Section("Ingredients") {
                ForEach(recipe.ingredients, id: \.self) { ingredient in
                    Text(ingredient)
                }
            }
        }
        .navigationTitle(recipe.title)
    }
}
