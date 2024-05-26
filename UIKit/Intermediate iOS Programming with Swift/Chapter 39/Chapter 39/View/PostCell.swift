//
//  PostCell.swift
//  Chapter 39
//
//  Created by mrgsdev on 26.05.2024
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var voteButton: LineButton! {
        didSet {
            voteButton.tintColor = .white
        }
    }

    @IBOutlet var photoImageView: UIImageView!
    
    @IBOutlet var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2
            avatarImageView.clipsToBounds = true
        }
    }
    
    private var currentPost: Post?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(post: Post) {

        // Set current post
        currentPost = post
        
        // Set the cell style
        selectionStyle = .none

        // Set name and vote count
        nameLabel.text = post.user
        voteButton.setTitle("\(post.votes)", for: .normal)
        voteButton.tintColor = .white
        
        // Reset image view's image
        photoImageView.image = nil
        
        // Download post image
        if let image = CacheManager.shared.getFromCache(key: post.imageFileURL) as? UIImage {
            if self.currentPost?.imageFileURL == post.imageFileURL {
                self.photoImageView.image = image
            }
            
        } else {
            if let url = URL(string: post.imageFileURL) {
                
                let downloadTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                    
                    guard let imageData = data else {
                        return
                    }
                    
                    OperationQueue.main.addOperation {
                        guard let image = UIImage(data: imageData) else { return }
                        
                        self.photoImageView.image = image
                        
                        // Add the downloaded image to cache
                        CacheManager.shared.cache(object: image, key: post.imageFileURL)
                    }
                    
                })
                
                downloadTask.resume()
            }
        }
    }
}
