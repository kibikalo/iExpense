import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    @Environment(\.dismiss) var dismiss
    var expenses: Expenses
    
    let types = ["Personal", "Business", "Gift"]
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .padding()
            .navigationTitle("Add New Expense")
            .toolbar {
                ToolbarItem (placement: .bottomBar) {
                    Button("Save") {
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        expenses.items.append(item)
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
