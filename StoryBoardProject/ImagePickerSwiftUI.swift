//
//  ImagePickerSwiftUI.swift
//  StoryBoardProject
//
//  Created by Danil Stefaniuc on 11.04.2021.
//

import Foundation
import SwiftUI
import UIKit
import Firebase


struct ImagePicker: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     
        private let storage = Storage.storage().reference()
        var parent: ImagePicker
     
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
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
            let downloadURLString = downloadURL.absoluteString
            UserDefaults.standard.set(downloadURLString, forKey: "url")
          }
        }
    }
    }
    
}
