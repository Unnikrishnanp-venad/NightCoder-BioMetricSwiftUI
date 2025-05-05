import SwiftUI


struct SliderView: View {
    
    @State private var currentPage = 0
    @State private var navigateToHome = false  // State for navigation
    
    let carouselItems: [CarouselItem] = [
        CarouselItem(imageName: "app-intro-01", title: "Hoida vakuutus- ja korvausasiasi sujuvasti puhelimella missä ja milloin vain."),
        CarouselItem(imageName: "app-intro-02", title: "Kun käytössäsi on hoitokuluja kattava vakuutus, kannattaa lääkärikäyntiä varten hakea etukäteen laskutuslupaa."),
        CarouselItem(imageName: "app-intro-03", title: "E-laskulla saat vakuutuslaskut suoraan verkkopankkiisi, jossa ne myös säilyvät turvallisesti."),
        CarouselItem(imageName: "app-intro-04", title: "Laskutuslupaa ei tarvitse käyttää vain vakuutuslaskutuspaikkaan, vaikka se on neuvottamaton muoto.")
    ]
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.red  // Active dot
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.lightGray          // Inactive dots
    }
    var body: some View {
        VStack{
            GeometryReader { geometry in
                TabView(selection: $currentPage) {
                    ForEach(0..<carouselItems.count, id: \.self){ index in
                        VStack(spacing: 20) {
                            Image(carouselItems[index].imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.6) // 60% width and 30% height
                            Text(carouselItems[index].title)
                                .font(.subheadline)
                                .foregroundColor(.blue)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                        }.tag(index)
                    }
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .animation(.easeInOut, value: currentPage) // Smooth animation
                
                Spacer()
                
                Button(action: {
                    if currentPage < carouselItems.count - 1 {
                        currentPage += 1 // Move to next page
                    } else {
                        // Last page - maybe navigate to home screen?
                        print("Get Started pressed!")
                        navigateToHome = true
                        // Save onboarding viewed status
                        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
                    }
                }) {
                    Text(currentPage == carouselItems.count - 1 ? "Get Started" : "Next")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 50) // Fixed height
                        .background(Color.blue)
                        .cornerRadius(25)
                        .padding(.horizontal)
                }
                .padding(.bottom, 30)
                // Hidden NavigationLink that triggers navigation
                // Navigation when "Get Started" is pressed
                .navigationDestination(isPresented: $navigateToHome) {
                    HomeView() // Navigate to HomeView
                }
            }.background(Color(.systemBackground))
            
        }
    }
}
