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
        guard var image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
            return
        }
        image = self.resizeImage(image: image, targetSize: CGSize(width: 1920.0, height: 1080.0))
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
        
        
        func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
           let size = image.size

           let widthRatio  = targetSize.width  / size.width
           let heightRatio = targetSize.height / size.height

           // Figure out what our orientation is, and use that to form the rectangle
           var newSize: CGSize
           if(widthRatio > heightRatio) {
               newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
           } else {
               newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
           }

           // This is the rect that we've calculated out and this is what is actually used below
           let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

           // Actually do the resizing to the rect using the ImageContext stuff
           UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
           image.draw(in: rect)
           let newImage = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()

           return newImage!
       }
    }
    
    
    

}
