//
//  ReviewViewController.swift
//  FoodPinCoreData
//
//  Created by mrgsdev on 03.05.2024.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet var rateButtons: [UIButton]!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet var backgroundImageView: UIImageView!{
        didSet{
            backgroundImageView.image = UIImage(data: restaurant.image)
            
        }
    }
    var restaurant = Restaurant()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurEffect()
        closeButton.alpha = 0
        let moveRightTransform = CGAffineTransform.init(translationX: 600, y: 0)
        for ratebutton in rateButtons{
            ratebutton.transform = moveRightTransform
            ratebutton.alpha = 0
        }
    }
    override func viewWillAppear(_ animated: Bool) {
         
         
        for index in 0...4 {
            UIView.animate(withDuration: 0.4, delay: (0.1 + 0.05 * Double(index)), options: []) {
                self.rateButtons[index].alpha = 1.0
                self.rateButtons[index].transform = .identity
            }    
        }
        UIView.animate(withDuration: 0.4, delay: 0.6, options: []) {
            self.closeButton.alpha = 1.0
            self.closeButton.transform = .identity
        }
        
    }
    func blurEffect()  {
        
        // Applying the blur effect
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
