import SwiftUI

struct NotesView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Content.date, ascending: false)],
        predicate: NSPredicate(format: "tag == %@", "Notes"),
        animation: .default)
    private var notes: FetchedResults<Content>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(notes) { note in
                    NavigationLink(destination: ContentDetailView(content: note)) {
                        ContentRow(content: note)
                    }
                }
            }
            .navigationTitle("Notes")
        }
    }
}