// Training the Model Programmatically
import Cocoa
import CreateML

let trainingDir = URL(fileURLWithPath: "Users/mrgsdev/Desktop/Chapter 43/training")
let testingDir = URL(fileURLWithPath: "Users/mrgsdev/Desktop/Chapter 43/testing")

// Train the model
let model = try MLImageClassifier(trainingData: .labeledDirectories(at: trainingDir))

// Evaluate the trained model with test data
let evaluation = model.evaluation(on: .labeledDirectories(at: testingDir))

// Export the model
try model.write(to: URL(fileURLWithPath: "/Users/mrgsdev/Desktop/Chapter 43/Chapter43ImageClassifier"))
