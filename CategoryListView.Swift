import SwiftUI
import FirebaseFirestore

struct CategoryListView: View {

    var documentID: String

    @State private var category: Category?
    @State private var refreshID = UUID()

    var body: some View {

        VStack {

            List {
                if let recipes = category?.recipes {

                    ForEach(recipes, id: \.title) { recipe in
                        NavigationLink(recipe.title) {
                            RecipeDetailView(
                                documentID: documentID,
                                recipe: recipe
                            )
                        }
                    }

                } else {
                    Text("Loading...")
                }
            }
            .id(refreshID)

            NavigationLink("Add New Recipe") {
                AddNewRecipeView(documentID: documentID)
            }
        }
        .navigationTitle(category?.name.capitalized ?? "Recipes")

        .toolbar {
            Button {
                fetchCategory()
            } label: {
                Image(systemName: "arrow.clockwise")
            }
        }

        .onAppear {
            fetchCategory()
        }
    }

    func fetchCategory() {

        let db = Firestore.firestore()

        db.collection("categories")
            .document(documentID)
            .getDocument { snapshot, error in

                if let error = error {
                    print("Error:", error.localizedDescription)
                    return
                }

                guard let snapshot = snapshot,
                      let data = snapshot.data() else {
                    print("No data found")
                    return
                }

                let name = data["name"] as? String ?? ""

                var recipes: [Recipe] = []

                if let recipeArray = data["recipes"] as? NSArray {

                    for item in recipeArray {

                        if let recipeData = item as? [String: Any] {

                            let title = recipeData["title"] as? String ?? ""

                            let ingredients = recipeData["ingredients"] as? [String] ?? []

                            recipes.append(
                                Recipe(
                                    title: title,
                                    ingredients: ingredients
                                )
                            )
                        }
                    }
                }

                self.category = Category(
                    id: snapshot.documentID,
                    name: name,
                    recipes: recipes
                )

                print("Loaded category:", name)
                print("Recipes loaded:", recipes.count)
                print("Recipe titles:", recipes.map { $0.title })

                refreshID = UUID()
            }
    }
}
