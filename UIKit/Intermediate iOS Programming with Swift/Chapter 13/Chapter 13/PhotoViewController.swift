//
//  PhotoViewController.swift
//  Chapter 13
//
//  Created by mrgsdev on 30.04.2024.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var image:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image
    }
    
    @IBAction func saving(sender:UIButton){
        guard let imageToSave = image else {
        return
        }
       
        UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil)
            
        dismiss(animated: true, completion: nil)
    }
}
