//
//  DraggableState.swift
//  Chapter 17
//
//  Created by mrgsdev on 27.09.2024.
//


import SwiftUI

enum DraggableState {
    case inactive
    case pressing
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive, .pressing:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isPressing: Bool {
        switch self {
        case .pressing, .dragging:
            return true
        case .inactive:
            return false
        }
    }
}

struct DraggableView<Content>: View where Content: View {
    @GestureState private var dragState = DraggableState.inactive
    @State private var position = CGSize.zero
    
    var content: () -> Content
    
    var body: some View {
        content()
            .opacity(dragState.isPressing ? 0.5 : 1.0)
            .offset(x: position.width + dragState.translation.width, y: position.height + dragState.translation.height)
            .animation(.easeInOut, value: dragState.translation)
            .gesture(
                LongPressGesture(minimumDuration: 1.0)
                .sequenced(before: DragGesture())
                .updating($dragState, body: { (value, state, transaction) in
                    
                    switch value {
                    case .first(true):
                        state = .pressing
                    case .second(true, let drag):
                        state = .dragging(translation: drag?.translation ?? .zero)
                    default:
                        break
                    }
                    
                })
                .onEnded({ (value) in
                    
                    guard case .second(true, let drag?) = value else {
                        return
                    }
                    
                    self.position.height += drag.translation.height
                    self.position.width += drag.translation.width
                })
            )
    }
}

#Preview {
    DraggableView() {
        Image(systemName: "star.circle.fill")
            .font(.system(size: 100))
            .foregroundColor(.green)
    }
}

#Preview {
    DraggableView() {
        Text("Swift")
            .font(.system(size: 50, weight: .bold, design: .rounded))
            .bold()
            .foregroundColor(.red)
    }
}

#Preview {
    DraggableView() {
        Circle()
            .frame(width: 100, height: 100)
            .foregroundColor(.purple)
    }
}
