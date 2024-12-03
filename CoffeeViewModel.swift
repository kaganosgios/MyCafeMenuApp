import Foundation
import FirebaseFirestore
class CoffeeViewModel: ObservableObject {
    @Published var coffeeList: [Coffee] = []
    private var db = Firestore.firestore()
    
    func fetchCoffees(completion: @escaping () -> Void) {
        db.collection("coffeeSuggestions").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching coffees: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }
            
            self.coffeeList = documents.compactMap { document -> Coffee? in
                let data = document.data()
                guard let name = data["name"] as? String,
                      let description = data["description"] as? String,
                      let imageUrl = data["imageUrl"] as? String,
                      let price = data["price"] as? Double else {
                    print("Error parsing document: \(document.data())")
                    return nil
                }
                return Coffee(id: document.documentID, name: name, price: price, imageUrl: imageUrl, description: description)
            }
            
            completion() // Veriler çekildikten sonra completion handler'ını çağırıyoruz
        }
    }
    
func deleteCoffee(coffee: Coffee) {
    db.collection("coffeeSuggestions").document(coffee.id).delete { error in
        if let error = error {
            print("Error deleting coffee: \(error.localizedDescription)")
        } else {
            self.coffeeList.removeAll { $0.id == coffee.id }
        }
    }
}
}





