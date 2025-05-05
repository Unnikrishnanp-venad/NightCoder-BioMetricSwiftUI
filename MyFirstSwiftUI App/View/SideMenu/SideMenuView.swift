import SwiftUI
import PhotosUI
struct SideMenu: View {
    @Binding var isShowing: Bool
    
    
    var content: AnyView
    var edgeTransition: AnyTransition = .move(edge: .leading)
    var body: some View {
        ZStack(alignment: .bottom) {
            if (isShowing) {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }
                content
                    .transition(edgeTransition)
                    .background(
                        Color.clear
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
    }
}
enum SideMenuRowType: Int, CaseIterable{
    case home = 0
    case favorite
    case chat
    case profile
    
    var title: String{
        switch self {
        case .home:
            return "Home"
        case .favorite:
            return "Favorite"
        case .chat:
            return "Chat"
        case .profile:
            return "Profile"
        }
    }
    
    var iconName: String{
        switch self {
        case .home:
            return "home"
        case .favorite:
            return "favorite"
        case .chat:
            return "chat"
        case .profile:
            return "profile"
        }
    }
}

struct SideMenuView: View {
    
    @Binding var selectedSideMenuTab: Int
    @Binding var presentSideMenu: Bool
    
    @State private var selectedImage: UIImage? = ImageStorageManager.loadImage()
    @State private var isShowingPhotoPicker = false
    
    var body: some View {
        HStack {
            
            ZStack{
                Rectangle()
                    .fill(.white)
                    .frame(width: 270)
                    .shadow(color: .purple.opacity(0.1), radius: 5, x: 0, y: 3)
                
                VStack(alignment: .leading, spacing: 0) {
                    ProfileImageView()
                        .frame(height: 140)
                        .padding(.bottom, 30)
                    
                    ForEach(SideMenuRowType.allCases, id: \.self){ row in
                        RowView(isSelected: selectedSideMenuTab == row.rawValue, imageName: row.iconName, title: row.title) {
                            selectedSideMenuTab = row.rawValue
                            presentSideMenu.toggle()
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top, 100)
                .frame(width: 270)
                .background(Color(UIColor.white))
            }
            
            
            Spacer()
        }
        .background(.clear)
    }
    
    func ProfileImageView() -> some View{
        VStack(alignment: .center) {
            HStack {
                Spacer()
                Button(action: {
                    isShowingPhotoPicker = true
                }) {
                    Group {
                        if let selectedImage = selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                        }
                    }
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width * 0.4, height:  UIScreen.main.bounds.width * 0.4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(.gray.opacity(0.5), lineWidth: 10)
                    )
                    .cornerRadius(( UIScreen.main.bounds.width * 0.4) / 2)
                }
                .sheet(isPresented: $isShowingPhotoPicker) {
                    PhotoPicker { image in
                        if let image = image {
                            self.selectedImage = image
                            ImageStorageManager.saveImage(image)
                        }
                    }
                }
                Spacer()
            }
        }
    }
 
    func RowView(isSelected: Bool, imageName: String, title: String, hideDivider: Bool = false, action: @escaping (()->())) -> some View{
        Button{
            action()
        } label: {
            VStack(alignment: .leading){
                HStack(spacing: 20){
                    Rectangle()
                        .fill(isSelected ? .gray : .white)
                        .frame(width: 5)
                    
                    ZStack{
                        Image(imageName)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(isSelected ? .black : .gray)
                            .frame(width: 26, height: 26)
                    }
                    .frame(width: 30, height: 30)
                    Text(title)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(isSelected ? .black : .gray)
                    Spacer()
                }
            }
        }
        .frame(height: 50)
        .background(
            LinearGradient(colors: [isSelected ? .gray.opacity(0.5) : .white, .white], startPoint: .leading, endPoint: .trailing)
        )
    }
}

struct PhotoPicker: UIViewControllerRepresentable {
    var onImagePicked: (UIImage?) -> Void
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onImagePicked: onImagePicked)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var onImagePicked: (UIImage?) -> Void
        
        init(onImagePicked: @escaping (UIImage?) -> Void) {
            self.onImagePicked = onImagePicked
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider,
                  provider.canLoadObject(ofClass: UIImage.self) else {
                onImagePicked(nil)
                return
            }
            
            provider.loadObject(ofClass: UIImage.self) { image, _ in
                DispatchQueue.main.async {
                    self.onImagePicked(image as? UIImage)
                }
            }
        }
    }
}


struct ImageStorageManager {
    static let fileName = "profile_image.png"

    // Get documents directory URL
    static private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    // Get full file URL for the image
    static private func fileURL() -> URL {
        getDocumentsDirectory().appendingPathComponent(fileName)
    }

    // Save UIImage as PNG
    static func saveImage(_ image: UIImage) {
        if let data = image.pngData() {
            try? data.write(to: fileURL())
        }
    }

    // Load saved UIImage
    static func loadImage() -> UIImage? {
        let url = fileURL()
        if let data = try? Data(contentsOf: url) {
            return UIImage(data: data)
        }
        return nil
    }

    // Remove saved image if needed
    static func deleteImage() {
        try? FileManager.default.removeItem(at: fileURL())
    }
}
