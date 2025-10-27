import SwiftUI

struct AddView: View {
    @State private var name = "Title"
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
                
                    TextField("Description", text: $description)
                    TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
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
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
