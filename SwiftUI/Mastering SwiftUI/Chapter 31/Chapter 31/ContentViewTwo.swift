//
//  ContentViewTwo.swift
//  Chapter 31
//
//  Created by mrgsdev on 14.10.2024.
//


import SwiftUI

struct ContentViewTwo: View {
    @State private var overallProgress = 0.0
    @State private var taskStore = [ Task(name: "Design", progress: 0.7),
                              Task(name: "Coding", progress: 0.5),
                              Task(name: "Documentation", progress: 0.1),
                              Task(name: "Unit Testing", progress: 0.2)
                              ]
    var body: some View {
        VStack(alignment: .leading) {
            Text("Daily Task")
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.black)
                .padding(.horizontal)
                .padding(.top)
            
            HStack {
                Text("Overall Progress")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                Spacer()
                
                ProgressRingViewTwo(progress: $overallProgress, thickness: 12.0, width: 130.0, gradient: Gradient(colors: [.darkYellow, .lightYellow]), textColor: .white)
                
            }
            .padding(.all, 20)
            .background(Color.purpleBg)
            .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
            .padding(.horizontal)
            
            LazyVGrid(columns: [GridItem()]) {
                ForEach(taskStore.indices, id: \.self) { index in
                    TaskProgressView(task: $taskStore[index])
                }
            }
            
            Spacer()
        }
        .onAppear {
            self.overallProgress = taskStore.reduce(0) { $0 + $1.progress } / Double(taskStore.count)
        }
        .onChange(of: taskStore, perform: { value in
            self.overallProgress = taskStore.reduce(0) { $0 + $1.progress } / Double(taskStore.count)
        })
        
    }
}


#Preview {
    ContentViewTwo()
}

struct TaskProgressView: View {
    
    @Binding var task: Task
    
    var sliderColor: Color = .lightOrange
    
    private var progressText: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.percentSymbol = "%"
        
        return formatter.string(from: NSNumber(value: task.progress)) ?? ""
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(task.name)
                    .font(.system(.headline, design: .rounded))
                
                Text(progressText)
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(Color.primary.opacity(0.8))
            }
            
                HStack {
                    Text("0%")
                        .font(.system(.subheadline, design: .rounded))
                    Slider(value: $task.progress, in: 0...1, step: 0.05)
                        .accentColor(sliderColor)
                    Text("100%")
                        .font(.system(.subheadline, design: .rounded))
                }
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
        .padding(.horizontal)
    }
}

