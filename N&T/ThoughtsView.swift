import SwiftUI

struct ThoughtsView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Content.date, ascending: false)],
        predicate: NSPredicate(format: "tag == %@", "Thoughts"),
        animation: .default)
    private var thoughts: FetchedResults<Content>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(thoughts) { thought in
                    NavigationLink(destination: ContentDetailView(content: thought)) {
                        ContentRow(content: thought)
                    }
                }
            }
            .navigationTitle("Thoughts")
        }
    }
}