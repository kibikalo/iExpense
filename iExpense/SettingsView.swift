import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem (placement: .bottomBar) {
                    Button("Back") {
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
