//
//  ContentView.swift
//  Chapter 52
//
//  Created by mrgsdev on 20.10.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query var todoItems: [ToDoItem]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(todoItems) { todoItem in
                    HStack {
                        Text(todoItem.name)
                        
                        Spacer()
                        
                        if todoItem.isComplete {
                            Image(systemName: "checkmark")
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        let itemToDelete = todoItems[index]
                        modelContext.delete(itemToDelete)
                    }
                })
            }
            
            .navigationTitle("To Do List")
            
            .toolbar {
                Button("", systemImage: "plus") {
                    modelContext.insert(generateRandomTodoItem())
                }
            }
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(previewContainer)
}


@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: ToDoItem.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        for _ in 1...10 {
            container.mainContext.insert(generateRandomTodoItem())
        }
        
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()


func generateRandomTodoItem() -> ToDoItem {
    let tasks = [ "Buy groceries", "Finish homework", "Go for a run", "Practice Yoga", "Read a book", "Write a blog post", "Clean the house", "Walk the dog", "Attend a meeting" ]
    
    let randomIndex = Int.random(in: 0..<tasks.count)
    let randomTask = tasks[randomIndex]
    
    return ToDoItem(name: randomTask, isComplete: Bool.random())
}

func generateRandomTodoItems(count: Int) -> [ToDoItem] {
    let tasks = [ "Buy groceries", "Finish homework", "Go for a run", "Practice Yoga", "Read a book", "Write a blog post", "Clean the house", "Walk the dog", "Attend a meeting" ]
    
    var todoItems: [ToDoItem] = []
    
    for _ in 1...count {
        let randomIndex = Int.random(in: 0..<tasks.count)
        let randomTask = tasks[randomIndex]
        let randomCompleted = Bool.random()
        let todoItem = ToDoItem(name: randomTask, isComplete: randomCompleted)
        todoItems.append(todoItem)
    }
    
    return todoItems
}

let randomTodoItems = generateRandomTodoItems(count: 8)
