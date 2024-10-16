//
//  ProgressRingView.swift
//  Chapter 31
//
//  Created by mrgsdev on 14.10.2024.
//


import SwiftUI

struct ProgressRingView: View {
    @Binding var progress: Double
    
    var thickness: CGFloat = 30.0
    var width: CGFloat = 250.0
    var gradient = Gradient(colors: [.darkPurple, .lightYellow])
    var startAngle = -90.0
    
    private var radius: Double {
        Double(width / 2)
    }
    
    private var progressText: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.percentSymbol = "%"
        
        return formatter.string(from: NSNumber(value: progress)) ?? ""
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemGray6), lineWidth: thickness)
                        
            RingShape(progress: progress, thickness: thickness)
                .fill(AngularGradient(gradient: gradient, center: .center, startAngle: .degrees(startAngle), endAngle: .degrees(360 * progress + startAngle)))
                .animatableProgressText(progress: progress)
            
            RingTip(progress: progress, startAngle: startAngle, ringRadius: radius)
                .frame(width: thickness, height: thickness)
                .foregroundColor(progress > 0.96 ? gradient.stops[1].color : Color.clear)
                .shadow(color: progress > 0.96 ? Color.black.opacity(0.15) : Color.clear, radius: 2, x: ringTipShadowOffset.x, y: ringTipShadowOffset.y)
        }
        .frame(width: width, height: width, alignment: .center)
        .animation(.easeInOut(duration: 1.0), value: progress)
    }
    
    private func ringTipPosition(progress: Double) -> CGPoint {
        let angle = 360 * progress + startAngle
        let angleInRadian = angle * .pi / 180
        
        return CGPoint(x: radius * cos(angleInRadian), y: radius * sin(angleInRadian))
    }
    
    private var ringTipShadowOffset: CGPoint {
        let shadowPosition = ringTipPosition(progress: progress + 0.01)
        let circlePosition = ringTipPosition(progress: progress)
        
        return CGPoint(x: shadowPosition.x - circlePosition.x, y: shadowPosition.y - circlePosition.y)
    }
}

#Preview("ProgressRingView (50%)") {
    ProgressRingView(progress: .constant(0.5))
}

#Preview("ProgressRingView (90%)") {
    ProgressRingView(progress: .constant(0.9))
}

#Preview("ProgressRingView (99%)") {
    ProgressRingView(progress: .constant(0.99))
}


struct RingShape: Shape {
    var progress: Double = 0.0
    var thickness: CGFloat = 30.0
    
    var startAngle: Double = -90.0
    
    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.width / 2.0, y: rect.height / 2.0),
                    radius: min(rect.width, rect.height) / 2.0,
                    startAngle: .degrees(startAngle),
                    endAngle: .degrees(360 * progress + startAngle), clockwise: false)
        
        return path.strokedPath(.init(lineWidth: thickness, lineCap: .round))
    }
}

struct RingTip: Shape {
    var progress: Double = 0.0
    var startAngle: Double = -90.0
    var ringRadius: Double
    
    private var position: CGPoint {
        let angle = 360 * progress + startAngle
        let angleInRadian = angle * .pi / 180
        
        return CGPoint(x: ringRadius * cos(angleInRadian), y: ringRadius * sin(angleInRadian))
    }
    
    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        guard progress > 0.0 else {
            return path
        }
                
        let frame = CGRect(x: position.x, y: position.y, width: rect.size.width, height: rect.size.height)
        
        path.addRoundedRect(in: frame, cornerSize: frame.size)
        
        return path
    }

}

struct ProgressTextModifier: AnimatableModifier {
    
    var progress: Double = 0.0
    var textColor: Color = .primary
    
    private var progressText: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.percentSymbol = "%"
        
        return formatter.string(from: NSNumber(value: progress)) ?? ""
    }
    
    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Text(progressText)
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundStyle(textColor)
                    .animation(nil)
            )
    }
}

extension View {
    func animatableProgressText(progress: Double, textColor: Color = Color.primary) -> some View {
        self.modifier(ProgressTextModifier(progress: progress, textColor: textColor))
    }
}

struct ProgressBar_Library: LibraryContentProvider {
    var views: [LibraryItem] {
        return [LibraryItem(ProgressRingView(progress: .constant(1.0), thickness: 12.0, width: 130.0, gradient: Gradient(colors: [.darkYellow, .lightYellow])), title: "Progress Ring", category: .control),
        
                LibraryItem(ProgressRingView(progress: .constant(1.0), thickness: 30.0, width: 250.0, gradient: Gradient(colors: [.darkPurple, .lightYellow])), title: "Progress Ring - Bigger", category: .control)]
    }
    
    @LibraryContentBuilder
    func modifiers(base: Circle) -> [LibraryItem] {
        LibraryItem(base.animatableProgressText(progress: 1.0), title: "Progress Indicator", category: .control)
    }
}
