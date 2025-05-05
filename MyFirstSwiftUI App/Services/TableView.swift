import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
}

struct TableView: View {
    let allItems: [Item] = [
        Item(title: "Apple", subtitle: "Fruit"),
        Item(title: "Carrot", subtitle: "Vegetable"),
        Item(title: "Salmon", subtitle: "Fish"),
        Item(title: "Milk", subtitle: "Dairy")
    ]
    
    @State private var searchText: String = ""
    var filteredItems: [Item] {
           if searchText.isEmpty {
               return allItems
           } else {
               return allItems.filter {
                   $0.title.localizedCaseInsensitiveContains(searchText) ||
                   $0.subtitle.localizedCaseInsensitiveContains(searchText)
               }
           }
       }
    var body: some View {
        NavigationView {
            List(filteredItems) { item in
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.headline)
                    Text(item.subtitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 4)
            }
            .searchable(text: $searchText, prompt: "Search items")
                     .navigationTitle("Contacts Search")
        }
    }
}
