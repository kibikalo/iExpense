import SwiftUI

struct ContentView: View {
    
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    @State private var showingSettings = false
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.description)
                                .font(.subheadline)
                        }
                        
                        Spacer()
                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .foregroundStyle(item.type == .income ? .green
                                             : item.type == .expense ? .red
                                             : .orange)
                        Image(systemName: item.type == .income ? "plus.circle"
                                             : item.type == .expense ? "minus.circle"
                                             : "arrow.right.circle")
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(
                              item.type == .income ? .green
                              : item.type == .expense ? .red
                              : .orange
                            )
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle(Text("iExpense"))
            .toolbar {
                ToolbarItem (placement: .topBarLeading) {
                    Button("Settings", systemImage: "gearshape") {
                        showingSettings = true
                    }
                }
                
                ToolbarItem (placement: .topBarTrailing) {
                    Button("Add Expense", systemImage: "plus") {
                        showingAddExpense = true
                    }
                }
                
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView()
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

