//
//  FeedViewController.swift
//  PhotoSharing
//
//  Created by Güray Gül on 26.01.2024.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var postDictionary = [Post]()
    //    var emailDictionary = [String]()
    //    var commentDictionary = [String]()
    //    var imageDictionary = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        firebaseGetData()
    }
    
    func firebaseGetData() {
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("Post").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    //                    self.emailDictionary.removeAll(keepingCapacity: false)
                    //                    self.imageDictionary.removeAll(keepingCapacity: false)
                    //                    self.commentDictionary.removeAll(keepingCapacity: false)
                    self.postDictionary.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        //let documentId = document.documentID
                        
                        if let imageUrl = document.get("imageUrl") as? String {
                            if let comment = document.get("comment") as? String {
                                if let email = document.get("email") as? String {
                                    
                                    let post = Post(email: email, comment: comment, imageUrl: imageUrl)
                                    self.postDictionary.append(post)
                                }
                            }
                        }
                        
                    }
                    
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDictionary.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell
        cell.emailText.text = postDictionary[indexPath.row].email
        cell.commentText.text = postDictionary[indexPath.row].comment
        cell.postImageView.sd_setImage(with: URL(string: self.postDictionary[indexPath.row].imageUrl))
        
        return cell
    }
    
}
