//
//  Article.swift
//  Chapter 37
//
//  Created by mrgsdev on 20.10.2024.
//



import Foundation

struct Article {
    var id: UUID = UUID()
    var title: String
    var imageURL: String
}

extension Article: Identifiable {}

let sampleArticles = [
    Article(title: "Using AsyncImage in SwiftUI", imageURL: "https://www.appcoda.com/wp-content/uploads/2021/06/nf5fsqhm-iy.jpg"),
    Article(title: "SwiftUI for iOS 15: How to Add Swipe Actions and Hide Line Separators in List View", imageURL: "https://www.appcoda.com/wp-content/uploads/2021/06/up7jsnodg2m.jpg"),
    Article(title: "Introduction to UI Testing in SwiftUI Using XCTest Framework", imageURL: "https://www.appcoda.com/wp-content/uploads/2021/06/ynr9lqfjeay.jpg"),
    Article(title: "Using matchedGeometryEffect to Create View Animations in iOS 14", imageURL: "https://www.appcoda.com/wp-content/uploads/2020/09/9o_b3nh0zni.jpg"),
    Article(title: "Adding a Launch Screen in SwiftUI Projects", imageURL: "https://www.appcoda.com/wp-content/uploads/2021/05/6wdruk7bvte.jpg"),
    Article(title: "How to Record Videos and Animated Gifs in Xcode 12.5", imageURL: "https://www.appcoda.com/wp-content/uploads/2021/05/up7jsnodg2m.jpg"),
    Article(title: "Working with Toolbar in SwiftUI", imageURL: "https://www.appcoda.com/wp-content/uploads/2021/04/06aomufm7jy.jpg"),
    Article(title: "Building 3D AR Apps Using Reality Composer and RealityKit", imageURL: "https://www.appcoda.com/wp-content/uploads/2021/04/realitykit-ar-demo-1680x1214.jpg"),
    Article(title: "How to Hide Disclosure Indicator in SwiftUI List", imageURL: "https://www.appcoda.com/wp-content/uploads/2021/04/ck0i9dnjtj0.jpg"),
    Article(title: "How to Use ScrollViewReader to Perform Programmatic Scrolling", imageURL: "https://www.appcoda.com/wp-content/uploads/2021/03/tb_cvduhuuc.jpg")
]
