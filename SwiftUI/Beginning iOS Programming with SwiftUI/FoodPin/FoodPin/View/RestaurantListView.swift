//
//  RestaurantListView.swift
//  FoodPin
//
//  Created by mrgsdev on 21.08.2024.
//

import SwiftUI
import SwiftData

struct RestaurantListView: View {
    @AppStorage("hasViewedWalkthrough") var hasViewedWalkthrough: Bool = false
    
    @Environment(\.modelContext) private var modelContext
    
    @Query var restaurants: [Restaurant]
    @State private var showNewRestaurant = false
    @State private var searchText = ""
    @State private var searchResult: [Restaurant] = []
    @State private var isSearchActive = false
    @State private var showWalkthrough = false
    
    var body: some View {
        NavigationStack {
            List {
                if restaurants.count == 0 {
                    Image("emptydata")
                        .resizable()
                        .scaledToFit()
                } else {
                    let listItems = isSearchActive ? searchResult : restaurants
                    
                    ForEach(listItems.indices, id: \.self) { index in
                        ZStack(alignment: .leading) {
                            NavigationLink(destination: RestaurantDetailView(restaurant: listItems[index])) {
                                EmptyView()
                            }
                            .opacity(0)
                            
                            BasicTextImageRow(restaurant: listItems[index])
                        }
                    }
                    .onDelete(perform: deleteRecord)
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            
            .navigationTitle("FoodPin")
            .navigationBarTitleDisplayMode(.automatic)
            
            .toolbar {
                Button(action: {
                    self.showNewRestaurant = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .tint(.primary)
        .onAppear() {
            showWalkthrough = hasViewedWalkthrough ? false : true
        }
        .sheet(isPresented: $showNewRestaurant) {
            NewRestaurantView()
        }
        .sheet(isPresented: $showWalkthrough) {
            TutorialView()
        }
        .searchable(text: $searchText, isPresented: $isSearchActive, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search restaurants...")
        .searchSuggestions{
            if searchText.isEmpty {
                Text("Cafe").searchCompletion("Cafe")
                Text("Thai").searchCompletion("Thai")
            }
        }
        .onChange(of: searchText) { oldValue, newValue in
            let predicate = #Predicate<Restaurant> { $0.name.localizedStandardContains(newValue) ||
                $0.location.localizedStandardContains(newValue)
            }
            
            let descriptor = FetchDescriptor<Restaurant>(predicate: predicate)
        
            if let result = try? modelContext.fetch(descriptor) {
                searchResult = result
            }
        }
        .onOpenURL(perform: { url in
            switch url.path {
            case "/NewRestaurant": showNewRestaurant = true
            default: return
            }
        })
        .task {
            prepareNotification()
        }
    }
    
    private func deleteRecord(indexSet: IndexSet) {
        
          for index in indexSet {
              let itemToDelete = restaurants[index]
              modelContext.delete(itemToDelete)
          }
    }
    
    private func prepareNotification() {
        // Make sure the restaurant array is not empty
        if restaurants.count <= 0 {
            return
        }

        // Pick a restaurant randomly
        let randomNum = Int.random(in: 0..<restaurants.count)
        let suggestedRestaurant = restaurants[randomNum]

        // Create the user notification
        let content = UNMutableNotificationContent()
        content.title = "Restaurant Recommendation"
        content.subtitle = "Try new food today"
        content.body = "I recommend you to check out \(suggestedRestaurant.name). The restaurant is one of your favorites. It is located at \(suggestedRestaurant.location). Would you like to give it a try?"
        content.sound = UNNotificationSound.default
        
        // Adding the image
        let tempDirURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let tempFileURL = tempDirURL.appendingPathComponent("suggested-restaurant.jpg")

        try? suggestedRestaurant.image.jpegData(compressionQuality: 1.0)?.write(to: tempFileURL)
            
        if let restaurantImage = try? UNNotificationAttachment(identifier: "restaurantImage", url: tempFileURL, options: nil) {
            content.attachments = [restaurantImage]
        }
        
        // Adding actions
        let categoryIdentifer = "foodpin.restaurantaction"
        let makeReservationAction = UNNotificationAction(identifier: "foodpin.makeReservation", title: "Reserve a table", options: [.foreground])
        let cancelAction = UNNotificationAction(identifier: "foodpin.cancel", title: "Later", options: [])
        let category = UNNotificationCategory(identifier: categoryIdentifer, actions: [makeReservationAction, cancelAction], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        content.categoryIdentifier = categoryIdentifer
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "foodpin.restaurantSuggestion", content: content, trigger: trigger)

        // Schedule the notification
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}

#Preview {
    RestaurantListView()
}

#Preview("Dark mode") {
    RestaurantListView()
        .preferredColorScheme(.dark)
}

#Preview("BasicTextImageRow", traits: .sizeThatFitsLayout) {
    BasicTextImageRow(restaurant: Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong", phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: UIImage(named: "cafedeadend")!, isFavorite: true))
}

#Preview("FullImageRow", traits: .sizeThatFitsLayout) {
    FullImageRow(imageName: "cafedeadend", name: "Cafe Deadend", type: "Cafe", location: "Hong Kong", isFavorite: .constant(true))
}

struct BasicTextImageRow: View {
    // MARK: - Binding
    
    @Bindable var restaurant: Restaurant
    
    // MARK: - State variables
    
    @State private var showOptions = false
    @State private var showError = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image(uiImage: restaurant.image)
                .resizable()
                .frame(width: 120, height: 118)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack(alignment: .leading) {
                Text(restaurant.name)
                    .font(.system(.title2, design: .rounded))
                
                Text(restaurant.type)
                    .font(.system(.body, design: .rounded))
                
                Text(restaurant.location)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundStyle(.gray)
            }
            
            if restaurant.isFavorite {
                Spacer()
                
                Image(systemName: "heart.fill")
                    .foregroundStyle(.yellow)
            }
        }
        .contextMenu {
            Button(action: {
                self.showError.toggle()
            }) {
                HStack {
                    Text("Reserve a table")
                    Image(systemName: "phone")
                }
            }
            
            Button(action: {
                self.restaurant.isFavorite.toggle()
            }) {
                HStack {
                    Text(restaurant.isFavorite ? "Remove from favorites" : "Mark as favorite")
                    Image(systemName: "heart")
                }
            }
            
            Button(action: {
                self.showOptions.toggle()
            }) {
                HStack {
                    Text("Share")
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
        .alert("Not yet available", isPresented: $showError) {
            Button("OK") {}
        } message: {
            Text("Sorry, this feature is not available yet. Please retry later.", comment: "The message displayed when a user selects to place a call to the restaurant.")
        }
        .sheet(isPresented: $showOptions) {
            
            let defaultText = "Just checking in at \(restaurant.name)"
            
            ActivityView(activityItems: [defaultText, restaurant.image])
        }
    }
}

struct FullImageRow: View {
    
    var imageName: String
    var name: String
    var type: String
    var location: String
    
    @Binding var isFavorite: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.system(.title2, design: .rounded))
                        
                    Text(type)
                        .font(.system(.body, design: .rounded))
                    
                    Text(location)
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundStyle(.gray)
                }
                
                if isFavorite {
                    Spacer()
                    
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.yellow)
                }

            }
            .padding(.horizontal)
            .padding(.bottom)
        }
    }
}
