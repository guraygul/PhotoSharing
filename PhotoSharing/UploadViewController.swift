//
//  UploadViewController.swift
//  PhotoSharing
//
//  Created by Güray Gül on 26.01.2024.
//

import UIKit
import Firebase
import FirebaseStorage

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func selectImage() {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didUploadTapped(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            
            imageReference.putData(data, metadata: nil) { (storageMetaData, error) in
                if error != nil {
                    self.throwAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "An error occured")
                } else {
                    imageReference.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            if let imageUrl = imageUrl {
                                let firestoreDatabase = Firestore.firestore()
                                let firestorePost = ["imageUrl" : imageUrl, "comment" : self.commentTextField.text!, "email" : Auth.auth().currentUser!.email!, "date" : FieldValue.serverTimestamp()] as [String : Any]
                                
                                firestoreDatabase.collection("Post").addDocument(data: firestorePost) { (error) in
                                    if error != nil {
                                        self.throwAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "An error occured!")
                                    } else {
                                        self.imageView.image = UIImage(systemName: "square.and.arrow.up")
                                        self.commentTextField.text = ""
                                        self.tabBarController?.selectedIndex = 0
                                    }
                                }
                            }
                            
                            
                            
                        }
                    }
                }
            }
        }
    }
    
    func throwAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}
