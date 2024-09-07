![Chapter 28](https://github.com/user-attachments/assets/9507159e-acb5-4e81-8774-adb766f8ea46)
Add the following code to `RestaurantListView`:
```swift
.onOpenURL(perform: { url in
   switch url.path {
     case "/NewRestaurant": showNewRestaurant = true
     default: return
   }
})
```
<img width="975" alt="image" src="https://github.com/user-attachments/assets/e4f86181-ff9e-4f70-a2de-5ce773afd11b">
