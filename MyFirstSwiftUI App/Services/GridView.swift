import SwiftUI
import Photos

struct GridView: View {
    @State private var photoItems: [PhotoItem] = []
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(photoItems) { item in
                    Image(uiImage: item.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 110, height: 110)
                        .clipped()
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .navigationTitle("Gallery")
        .onAppear {
            loadGalleryPhotos()
        }
    }

    func loadGalleryPhotos() {
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized || status == .limited else { return }

            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

            let assets = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            let imageManager = PHCachingImageManager()
            let targetSize = CGSize(width: 200, height: 200)

            var loadedItems: [PhotoItem] = []
            let group = DispatchGroup()

            assets.enumerateObjects { asset, _, _ in
                group.enter()
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: nil) { image, _ in
                    if let image = image {
                        loadedItems.append(PhotoItem(image: image))
                    }
                    group.leave()
                }
            }

            group.notify(queue: .main) {
                self.photoItems = loadedItems
            }
        }
    }
}
