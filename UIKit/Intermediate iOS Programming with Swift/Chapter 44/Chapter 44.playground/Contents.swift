import CreateML
import Foundation

let dataPath = URL(fileURLWithPath: "/Users/YOUR_NAME/FOLDER/CSV File/sample_reviews.csv")

// Load the data set
let dataSet = try MLDataTable(contentsOf: dataPath)

let (trainingData, testingData) = dataSet.randomSplit(by: 0.8, seed: 5)

let textClassifier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "label")

// Find out the accuracy of the ML model in percentage
let trainingAccuracy = (1.0 - textClassifier.trainingMetrics.classificationError) * 100
let validationAccuracy = (1.0 - textClassifier.validationMetrics.classificationError) * 100

let evaluationMetrics = textClassifier.evaluation(on: testingData, textColumn: "text", labelColumn: "label")
let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100

if evaluationAccuracy >= 80.0 {
    let modelInfo = MLModelMetadata(author: "Simon Ng", shortDescription: "A trained model to classify review sentiment", license: "MIT", version: "1.0", additional: nil)
    try textClassifier.write(to: URL(fileURLWithPath: "/Users/simon/Downloads/SentimentClassifier.mlmodel"), metadata: modelInfo)
}

