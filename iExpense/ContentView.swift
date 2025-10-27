import SwiftUI

struct ContentView: View {
    
    @State private var expenses = Expenses()
    @State private var showingSettings = false
    
    var body: some View {
        
        NavigationStack {
            List {
                Section("Unsorted") {
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
                            
                            Image(systemName: item.type == .income ? "plus.circle.fill"
                                  : item.type == .expense ? "minus.circle.fill"
                                  : "arrow.right.circle.fill")
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
            }
            .navigationTitle(Text("iExpense"))
            .toolbar {
                ToolbarItem (placement: .topBarLeading) {
                    Button("Settings", systemImage: "gearshape") {
                        showingSettings = true
                    }
                }
                
                ToolbarItem (placement: .topBarTrailing) {
                    NavigationLink {
                        AddView(expenses: expenses)
                    } label: {
                        Label("Add Expense", systemImage: "plus")
                    }
                }
                
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

