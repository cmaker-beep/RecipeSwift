import SwiftUI
import FirebaseFirestore

struct MainView: View {

    @State private var categories: [Category] = []

    var body: some View {
        NavigationView {
            List(categories) { category in
                NavigationLink(category.name.capitalized) {
                    CategoryListView(documentID: category.id ?? "")
                }
            }
            .navigationTitle("Categories")
        }
        .onAppear(perform: fetchCategories)
    }

    func fetchCategories() {

        let db = Firestore.firestore()

        db.collection("categories")
            .order(by: "name")
            .getDocuments { snapshot, error in

                if let error = error {
                    print("Firestore Error:", error.localizedDescription)
                    return
                }

                guard let documents = snapshot?.documents else {
                    print("No documents found")
                    return
                }

                self.categories = documents.map { doc in

                    let data = doc.data()

                    let name = data["name"] as? String ?? ""

                    return Category(
                        id: doc.documentID,
                        name: name,
                        recipes: []
                    )
                }

                print("Categories loaded:", self.categories.count)
            }
    }
}
