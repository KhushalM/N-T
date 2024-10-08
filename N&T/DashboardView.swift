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
        HStack {
            if let imageData = content.imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(content.tag == "Notes" ? Theme.primaryColor : Theme.secondaryColor)
                    .frame(width: 60, height: 60)
                    .overlay(
                        Image(systemName: content.tag == "Notes" ? "note.text" : "brain")
                            .foregroundColor(.white)
                    )
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(content.title ?? "")
                    .font(.headline)
                    .foregroundColor(Theme.textColor)
                Text(content.date ?? Date(), style: .date)
                    .font(.subheadline)
                    .foregroundColor(Theme.textColor.opacity(0.7))
                Text(content.tag ?? "")
                    .font(.caption)
                    .padding(4)
                    .background(content.tag == "Notes" ? Theme.primaryColor.opacity(0.3) : Theme.secondaryColor.opacity(0.3))
                    .cornerRadius(4)
            }
        }
        .padding(.vertical, 8)
    }
}