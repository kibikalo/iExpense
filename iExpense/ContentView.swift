import SwiftUI

struct ContentView: View {
    
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                                .font(.subheadline)
                        }
                        
                        Spacer()
                        Text(item.amount, format: .currency(code: "PLN"))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle(Text("iExpense"))
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
