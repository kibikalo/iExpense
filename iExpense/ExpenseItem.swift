import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let type: ExpenseType
    let name: String
    let description: String
    let amount: Double
}

enum ExpenseType: String, CaseIterable, Identifiable, Codable {
    case expense = "Expense"
    case income = "Income"
    case transfer = "Transfer"
    
    var id: String { rawValue }
}
