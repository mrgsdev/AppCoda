//
//  ViewController.swift
//  Chapter 44
//
//  Created by mrgsdev on 31.05.2024
//

import UIKit
import NaturalLanguage

enum Sentiment: String {
    case positive = "positive"
    case negative = "negative"
}

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.textContainerInset = UIEdgeInsets(top: 40.0, left: 20.0, bottom: 20.0, right: 20.0)
            textView.text = "Write\nsomething\nhere\nto\nget\nstarted\nwith\nsentiment\nanalysis"
            textView.tintColor = UIColor.white
            textView.delegate = self
        }
    }
    
    @IBOutlet weak var emojiLabel: UILabel! {
        didSet {
            emojiLabel.text = "🤷🏻‍♀️"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension ViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        guard text == "\n" else {
            return true
        }
        
        // When the "return" key detected
        // - hide the keyboard
        // - predict the sentiment
        textView.resignFirstResponder()
        if let sentiment = predictSentiment(textView.text) {
            switch sentiment {
            case .positive: emojiLabel.text = "👍"
            case .negative: emojiLabel.text = "👎"
            }
        } else {
            emojiLabel.text = "🤷🏻‍♀️"
        }
        
        return false
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
    func predictSentiment(_ text: String) -> Sentiment? {
        
        guard !text.isEmpty else {
            return nil
        }
        
        guard let modelURL = Bundle.main.url(forResource: "Chapter 45 Model", withExtension: "mlmodelc") else {
            
            return nil
        }
            
        let model = try! NLModel(contentsOf: modelURL)
            
        guard let sentimentText = model.predictedLabel(for: text) else {
            return nil
        }

        return Sentiment(rawValue: sentimentText)
        
    }
}

