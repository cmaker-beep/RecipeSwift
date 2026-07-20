//
//  Category.swift
//  RecipeV1
//
//  Created by Chris Maker on 20/7/2026.
//
import SwiftUI
import FirebaseFirestore




struct Category: Identifiable {
    var id: String?
    var name: String
    var recipes: [Recipe]
}

