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
       // image = self.resizeImage(image: image, targetSize: CGSize(width: 600.0, height: 883.0))
        guard let imageData = image.pngData() else{
            return
        }
        
        let storageRef = storage.child("images/file.png")
    
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let uploadTask = storageRef.putData(imageData, metadata: metadata) { (metadata, error) in
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
//
            print("Download URL: \(downloadURL)")
            let downloadURLString = downloadURL.absoluteString
            self.uploadToServer(downloadURL: downloadURLString)
            
          }
        }
    }
        
        func uploadToServer(downloadURL : String){
            
//            let parameters = ["url": "https://media2.s-nbcnews.com/i/newscms/2019_18/1429065/how-to-find-your-skin-type-today-main-002-190424_c9a914b38344e66226253843f3f552bf.jpg"]
//            AF.request("http://127.0.0.1:5000/process-image", method: .post, parameters: parameters, encoding: URLEncoding.httpBody)
            
            // prepare json data
            let session = URLSession.shared
            let json: [String: Any] = ["url": downloadURL]
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            
            
         
            
            // create post request
            let url = URL(string: "http://127.0.0.1:5000/process-image")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")

            // insert json data to the request
            request.httpBody = jsonData
            
           
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                   print(responseJSON["processed_image_url"] as? String)
                    UserDefaults.standard.set(responseJSON["processed_image_url"] as? String, forKey: "url")
                }
            }
            task.resume()
       }
        
           func convertJsonToString(json: Any, prettyPrinted: Bool = false) -> String {
            var options: JSONSerialization.WritingOptions = []
            if prettyPrinted {
              options = JSONSerialization.WritingOptions.prettyPrinted
            }

            do {
              let data = try JSONSerialization.data(withJSONObject: json, options: options)
              if let string = String(data: data, encoding: String.Encoding.utf8) {
                return string
              }
            } catch {
              print(error)
            }

            return ""
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
