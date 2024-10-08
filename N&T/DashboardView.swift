import SwiftUI

struct DashboardView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Content.date, ascending: false)],
        animation: .default)
    private var contents: FetchedResults<Content>
    
    @State private var selectedDate: Date = Date()
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                
                List {
                    ForEach(filteredContents) { content in
                        NavigationLink(destination: ContentDetailView(content: content)) {
                            ContentRow(content: content)
                        }
                    }
                }
            }
            .navigationTitle("Dashboard")
        }
    }
    
    var filteredContents: [Content] {
        contents.filter { Calendar.current.isDate($0.date ?? Date(), inSameDayAs: selectedDate) }
    }
}

struct ContentRow: View {
    let content: Content
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(content.title ?? "")
                .font(.headline)
            Text(content.date ?? Date(), style: .time)
                .font(.subheadline)
            Text(content.tag ?? "")
                .font(.caption)
                .padding(4)
                .background(content.tag == "Notes" ? Color.blue.opacity(0.3) : Color.red.opacity(0.3))
                .cornerRadius(4)
        }
    }
}