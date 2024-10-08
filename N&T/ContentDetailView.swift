import SwiftUI

struct ContentDetailView: View {
    let content: Content
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let coverImageData = content.coverImageData, let uiImage = UIImage(data: coverImageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                        .foregroundColor(Theme.textColor)
                }
                
                Text(content.title ?? "")
                    .font(.title)
                    .foregroundColor(Theme.textColor)
                
                Text(content.date ?? Date(), style: .date)
                    .font(.subheadline)
                    .foregroundColor(Theme.textColor.opacity(0.7))
                
                Text(content.tag ?? "")
                    .font(.caption)
                    .padding(4)
                    .background(content.tag == "Notes" ? Theme.primaryColor.opacity(0.3) : Theme.secondaryColor.opacity(0.3))
                    .cornerRadius(4)
                
                Text(content.content ?? "")
                    .foregroundColor(Theme.textColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if let bulletPoints = content.bulletPoints as? [String], !bulletPoints.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(bulletPoints, id: \.self) { point in
                            HStack(alignment: .top) {
                                Text("•")
                                Text(point)
                            }
                            .foregroundColor(Theme.textColor)
                        }
                    }
                }
                
                if let imageData = content.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)  // Add this line
            .padding()
        }
        .navigationTitle(content.title ?? "")
        .background(Theme.backgroundColor)
    }
}