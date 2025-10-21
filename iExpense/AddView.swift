import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type: ExpenseType = .expense
    @State private var amount = 0.0
    @State private var description = ""
    
    @Environment(\.dismiss) var dismiss
    var expenses: Expenses
    
    var body: some View {
        NavigationStack {
            VStack () {
                Form {
                    Picker("Type", selection: $type) {
                        ForEach(ExpenseType.allCases) { kind in
                            Text(kind.rawValue).tag(kind)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                    TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("New Expense")
            .toolbar {
                ToolbarItem (placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                    .tint(.red)
                }
                
                ToolbarItem (placement: .confirmationAction) {
                    Button("Save") {
                        let item = ExpenseItem(type: type, name: name, description: description, amount: amount)
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
