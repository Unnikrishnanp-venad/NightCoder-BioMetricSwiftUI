
https://github.com/user-attachments/assets/a799935b-b511-47a2-bb6e-5475f3d07422

# SwiftUI Multi-Feature iOS App

A SwiftUI-based iOS application showcasing modern iOS development techniques including **Biometric Authentication**, **Contact Picker**, **Gallery Image Picker with Persistent Storage**, **Side Menu**, and **Tab-based Navigation**.

---

## ✨ Features

- 🔐 **Biometric Authentication**
  - Face ID / Touch ID authentication using `LocalAuthentication`
  
- 📇 **Contact Picker**
  - Fetch and display contacts using `ContactsUI`
  - Select and use contact information in your app

- 🖼 **Gallery Image Picker + Storage**
  - Pick images from the photo library
  - Persist selected images to local storage (e.g. `FileManager` or `UserDefaults`)
  - Display stored image across app launches

- 📁 **Side Menu Navigation**
  - Custom animated side menu
  - Profile display with dynamic image loading
  - Menu navigation to different views (Home, Favorites, Chat, Profile)

- 🧭 **TabBar Interface**
  - Seamless tab-based navigation
  - Fully customizable with system icons and titles

---

## 🛠 Technologies Used

- `SwiftUI`
- `LocalAuthentication`
- `ContactsUI`
- `PhotosUI`
- `FileManager` for local image storage
- `NavigationStack`, `TabView`, `ZStack`, and `@Binding` for app structure
- MVVM-like structure with separation of logic and UI

---

## 📸 Screenshots

| Biometric Login | Contact Picker | Gallery Picker | Side Menu |
|------------------|----------------|----------------|-----------|
| (Insert Screenshot) | (Insert Screenshot) | (Insert Screenshot) | (Insert Screenshot) |

---

## 🚀 Getting Started

### Requirements
- iOS 15.0+
- Xcode 14+
- Swift 5.7+

### Installation
1. Clone this repo:
    ```bash
    git clone https://github.com/yourusername/swiftui-multi-feature-app.git
    ```
2. Open the `.xcodeproj` or `.xcworkspace` in Xcode
3. Run the app on a simulator or real device

### Permissions
Ensure you update the following `Info.plist` keys:

```xml
<key>NSFaceIDUsageDescription</key>
<string>This app uses Face ID for authentication</string>
<key>NSContactsUsageDescription</key>
<string>This app accesses your contacts</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs access to your photo library</string>









https://github.com/user-attachments/assets/6bb9766f-09d2-41c1-8144-2631bdb8e4e9



