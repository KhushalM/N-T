import SwiftUI

struct AddContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var content = ""
    @State private var tag = "Notes"
    @State private var image: UIImage?
    @State private var showingImagePicker = false
    @State private var bulletPoints: [String] = [""]
    @State private var coverImage: UIImage?
    @State private var showingCoverImagePicker = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Cover Image")) {
                    Button(action: {
                        showingCoverImagePicker = true
                    }) {
                        Text("Add Cover Image")
                    }
                    
                    if let image = coverImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    }
                }
                
                Section(header: Text("Title")) {
                    TextField("Enter title", text: $title)
                }
                
                Section(header: Text("Content")) {
                    TextEditor(text: $content)
                        .frame(height: 200)
                }
                
                Section(header: Text("Bullet Points")) {
                    ForEach(0..<bulletPoints.count, id: \.self) { index in
                        HStack {
                            Text("•")
                            TextField("Bullet point", text: $bulletPoints[index])
                        }
                    }
                    Button("Add Bullet Point") {
                        bulletPoints.append("")
                    }
                }
                
                Section(header: Text("Tag")) {
                    Picker("Select tag", selection: $tag) {
                        Text("Notes").tag("Notes")
                        Text("Thoughts").tag("Thoughts")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Image")) {
                    Button(action: {
                        showingImagePicker = true
                    }) {
                        Text("Add Image")
                    }
                    
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    }
                }
                
                Button(action: submitContent) {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                }
                .disabled(title.isEmpty || (content.isEmpty && bulletPoints.allSatisfy { $0.isEmpty }))
            }
            .navigationTitle("Add Content")
            .sheet(isPresented: $showingCoverImagePicker) {
                ImagePicker(image: $coverImage)
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $image)
            }
        }
        .background(Color.yellow) // Add this line to check if the view is rendering
    }
    
    func submitContent() {
        let newContent = Content(context: viewContext)
        newContent.id = UUID()
        newContent.title = title
        newContent.content = content
        newContent.bulletPoints = bulletPoints.filter { !$0.isEmpty } as NSArray
        newContent.tag = tag
        newContent.date = Date()
        newContent.imageData = image?.jpegData(compressionQuality: 0.8)
        newContent.coverImageData = coverImage?.jpegData(compressionQuality: 0.8)
        
        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        // Reset form
        title = ""
        content = ""
        tag = "Notes"
        image = nil
        bulletPoints = [""]
        coverImage = nil
    }
}
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) private var presentationMode

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
