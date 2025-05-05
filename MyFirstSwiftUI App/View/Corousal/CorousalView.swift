import SwiftUI


struct CorousalView: View {
    
    @State private var currentPage = 0
    @State private var navigateToHome = false  // State for navigation
    
    let carouselItems: [CarouselItem] = [
        CarouselItem(imageName: "app-intro-01", title: "Discover a smarter way to browse, order, and manage your school uniforms—all in one place.."),
        CarouselItem(imageName: "app-intro-02", title: "Easily browse and order the right uniforms for your school with just a few taps."),
        CarouselItem(imageName: "app-intro-03", title: "Get notified about delivery updates, new stock, and school-specific changes instantly."),
        CarouselItem(imageName: "app-intro-04", title: "Organize your uniform purchases, check size guides, and set reminders for the next school year.")
    ]
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.red  // Active dot
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.lightGray          // Inactive dots
    }
    var body: some View {
        VStack {
            GeometryReader { geometry in
                VStack {
                    TabView(selection: $currentPage) {
                        ForEach(0..<carouselItems.count, id: \.self) { index in
                            VStack(spacing: 20) {
                                Image(carouselItems[index].imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.6)
                                Text(carouselItems[index].title)
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 20)
                            }
                            .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .animation(.easeInOut, value: currentPage)

                    Spacer()

                    Button(action: {
                        if currentPage < carouselItems.count - 1 {
                            currentPage += 1
                        } else {
                            print("Get Started pressed!")
                            navigateToHome = true
                            UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
                        }
                    }) {
                        Text(currentPage == carouselItems.count - 1 ? "Get Started" : "Next")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.blue)
                            .cornerRadius(25)
                            .padding(.horizontal)
                    }
                    .padding(.bottom, 30)
                    .navigationDestination(isPresented: $navigateToHome) {
                        HomeView()
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}
