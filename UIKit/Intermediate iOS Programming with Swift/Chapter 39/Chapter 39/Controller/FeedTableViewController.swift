//
//  FeedTableViewController.swift
//  Chapter 39
//
//  Created by mrgsdev on 26.05.2024
//

import UIKit
import YPImagePicker
import Firebase
import FirebaseStorage

class FeedTableViewController: UITableViewController {

    var postfeed: [Post] = []
    fileprivate var isLoadingPost = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the pull to refresh
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = UIColor.black
        refreshControl?.tintColor = UIColor.white
        refreshControl?.addTarget(self, action: #selector(loadRecentPosts), for: UIControl.Event.valueChanged)
        
        // Load recent posts
        loadRecentPosts()
    }

    // MARK: - Camera

    @IBAction func openCamera(_ sender: Any) {
        
        var config = YPImagePickerConfiguration()
        config.colors.tintColor = .black
        config.wordings.next = "OK"
        config.showsPhotoFilters = false
        
        let picker = YPImagePicker(configuration: config)
        
        picker.didFinishPicking { [unowned picker] items, _ in
            
            guard let photo = items.singlePhoto
            else {
                picker.dismiss(animated: true, completion: nil)
                
                return
            }
            
            PostService.shared.uploadImage(image: photo.image) {
                picker.dismiss(animated: true, completion: nil)
                self.loadRecentPosts()
            }
            
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    // MARK: - Managing Post Download and Display

    @objc fileprivate func loadRecentPosts() {
       
       isLoadingPost = true
       
       PostService.shared.getRecentPosts(start: postfeed.first?.timestamp, limit: 10) { (newPosts) in
           
           if newPosts.count > 0 {
               // Add the array to the beginning of the posts arrays
               self.postfeed.insert(contentsOf: newPosts, at: 0)
           }
           
           self.isLoadingPost = false
           
           if let _ = self.refreshControl?.isRefreshing {
               // Delay 0.5 second before ending the refreshing in order to make the animation look better
               DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                   self.refreshControl?.endRefreshing()
                   self.displayNewPosts(newPosts: newPosts)
               })
           } else {
               self.displayNewPosts(newPosts: newPosts)
           }
           
       }
   }

    private func displayNewPosts(newPosts posts: [Post]) {
        // Make sure we got some new posts to display
        guard posts.count > 0 else {
            return
        }
        
        // Display the posts by inserting them to the table view
        var indexPaths:[IndexPath] = []
        self.tableView.beginUpdates()
        for num in 0...(posts.count - 1) {
            let indexPath = IndexPath(row: num, section: 0)
            indexPaths.append(indexPath)
        }
        self.tableView.insertRows(at: indexPaths, with: .fade)
        self.tableView.endUpdates()
    }
}

// MARK: - UITableViewDataSource Methods

extension FeedTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PostCell
        
        let currentPost = postfeed[indexPath.row]
        cell.configure(post: currentPost)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postfeed.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // We want to trigger the loading when the user reaches the last two rows
        guard !isLoadingPost, postfeed.count - indexPath.row == 2 else {
            return
        }
        
        isLoadingPost = true
        
        guard let lastPostTimestamp = postfeed.last?.timestamp else {
            isLoadingPost = false
            return
        }
        
        PostService.shared.getOldPosts(start: lastPostTimestamp, limit: 3) { (newPosts) in
            // Add new posts to existing arrays and table view
            var indexPaths:[IndexPath] = []
            self.tableView.beginUpdates()
            for newPost in newPosts {
                self.postfeed.append(newPost)
                let indexPath = IndexPath(row: self.postfeed.count - 1, section: 0)
                indexPaths.append(indexPath)
            }
            self.tableView.insertRows(at: indexPaths, with: .fade)
            self.tableView.endUpdates()
            
            self.isLoadingPost = false
        }
    }
}
