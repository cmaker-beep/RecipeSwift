//
//  AddNewRecipeView.swift
//  RecipeV1
//
//  Created by Chris Maker on 20/7/2026.
//

import SwiftUI
import FirebaseFirestore
import FirebaseCore

    
struct AddNewRecipeView: View {
var documentID: String
@State private var title: String = ""
@State private var ingredients: [String] = []
@State private var newIngredient: String = ""
@State private var showAlert = false
@Environment(\.dismiss) var dismiss
var body: some View {
VStack {
TextField("Title", text: $title)
ForEach(ingredients.indices, id: \.self) { index in
TextField("Ingredient", text: $ingredients[index])
}
HStack {
TextField("New ingredient", text: $newIngredient)
Button("Add") {
addIngredient()
}
}
Button("Save Recipe") {
saveNewRecipe()
}
.alert("Recipe saved", isPresented: $showAlert) {
Button("OK") { dismiss() }
}
}
.padding()
}
func addIngredient() {
if !newIngredient.isEmpty {
ingredients.append(newIngredient)
newIngredient = ""
}
}
func saveNewRecipe() {
let db = Firestore.firestore()
let newRecipe: [String: Any] = [
"title": title,
"ingredients": ingredients
]
db.collection("categories")
.document(documentID)
.updateData([
"recipes": FieldValue.arrayUnion([newRecipe])
]) { error in
if error == nil {
showAlert = true
title = ""
ingredients = []
}
}
}
}
