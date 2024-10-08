import SwiftUI

struct ContentDetailView: View {
    let content: Content
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(content.title ?? "")
                    .font(.title)
                
                Text(content.date ?? Date(), style: .date)
                    .font(.subheadline)
                
                Text(content.tag ?? "")
                    .font(.caption)
                    .padding(4)
                    .background(content.tag == "Notes" ? Color.blue.opacity(0.3) : Color.red.opacity(0.3))
                    .cornerRadius(4)
                
                if let imageData = content.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                }
                
                Text(content.content ?? "")
                
                if let bulletPoints = content.bulletPoints as? [String], !bulletPoints.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(bulletPoints, id: \.self) { point in
                            HStack(alignment: .top) {
                                Text("•")
                                Text(point)
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle(content.title ?? "")
    }
}