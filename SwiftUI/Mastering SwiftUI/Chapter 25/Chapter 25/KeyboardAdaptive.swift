//
//  KeyboardAdaptive.swift
//  Chapter 25
//
//  Created by mrgsdev on 10.10.2024.
//


import Foundation
import SwiftUI
import Combine

struct KeyboardAdaptive: ViewModifier {
  
    @State var currentHeight: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .padding(.bottom, currentHeight)
            .onAppear(perform: handleKeyboardEvents)
    }

    private func handleKeyboardEvents() {
        
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification
        ).compactMap { (notification) in
            notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect
        }.map { rect in
            rect.height
        }.subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
        
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification
        ).compactMap { _ in
            CGFloat.zero
        }.subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))

    }
}

extension View {
    func keyboardAdaptive() -> some View {
        if #available(iOS 14.0, *) {
            return AnyView(self)
        } else {
            return AnyView(ModifiedContent(content: self, modifier: KeyboardAdaptive()))
        }
    }
}
