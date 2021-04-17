//
//  UploadViewController.swift
//  StoryBoardProject
//
//  Created by Danil Stefaniuc on 15.03.2021.
//

import UIKit
import FirebaseStorage
import ProgressHUD
import SwiftUI


class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITableViewDelegate {
    
    

    
    
    
    
    private let storage = Storage.storage().reference()
    
    
    //MARK: -IBQutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
               
    }
    

    //MARK: UIImagePicker Controller Functions
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
            return
        }
        guard let imageData = image.pngData() else{
            return
        }
        
       let storageRef = storage.child("images/file.png")
    
        
        let uploadTask = storageRef.putData(imageData, metadata: nil) { (metadata, error) in
          guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            return
          }
          // Metadata contains file metadata such as size, content-type.
          let size = metadata.size
          // You can also access to download URL after upload.
          storageRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
              // Uh-oh, an error occurred!
              return
            }
            print("Download URL: \(downloadURL)")
          }
        }
            
        
        //get download URL
        //save download URL to userDefaults
    }
 
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
            
        
    }
    
    
    //MARK: -IBActions
    
    @IBAction func uploadImageBtnPressed(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
            
    }
    
}



    

