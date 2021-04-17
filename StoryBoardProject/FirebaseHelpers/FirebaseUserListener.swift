//
//  FirebaseUserListener.swift
//  StoryBoardProject
//
//  Created by Danil Stefaniuc on 14.03.2021.
//

import Foundation
import Firebase

class FirebaseUserListener{
    static let shared = FirebaseUserListener()
    
    private init(){}
    
    //MARK: -Login
    
    func loginUserWithEmail(email: String, password: String, completion: @escaping (_ error:Error?, _ isEmailVerified: Bool)->Void){
        
        Auth.auth().signIn(withEmail: email, password: password){ (authDataResult, error) in
            
         
            
            if error == nil && authDataResult!.user.isEmailVerified{
                
                FirebaseUserListener.shared.downloadUserFromFirebase(userId: authDataResult!.user.uid, email: email)
               completion(error, true)
            }
            else{
                print("email is not verified")
                completion(error,false)
            }
        }
        
    }
    
    //MARK : -Registration
    
    func registerUserWith(email: String, password: String, completion: @escaping (_ error:Error?)->Void){
        
        //escabing is similar to lambda in C
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            completion(error)
            if error == nil{
            //send verification email
                authDataResult!.user.sendEmailVerification{(error) in print("auth email sent with error: ", error?.localizedDescription)}
                
                //create and save user
                if authDataResult?.user != nil{
                    
                    let user = User(id: authDataResult!.user.uid, username: email, email: email, pushId: "", avatarLink: "", status: "SkinCare is important!")
                    
                    saveUserLocally(user)
                    self.saveUserToFirestore(user)
                    
                    
                    
                }
            }
            
            
        }
        
        
    }
    
    
    //MARK: -Resend password
    
    func resetPasswordFor(email: String, completion: @escaping (_ error: Error?)->Void){
        
        Auth.auth().sendPasswordReset(withEmail: email){(error) in
            completion(error)
            
        }
    }
    
    
    //MARK: -Save users
    
    func saveUserToFirestore(_ user:User){
      
        do{
            try FireBaseReference(.User).document(user.id).setData(from: user)
             
           
        }catch{
            print(error.localizedDescription,"adding user")
            
        }
      }
    
    //MARK: -Download User from Firebase
    
    func downloadUserFromFirebase(userId: String, email: String? = nil){
        FireBaseReference(.User).document(userId).getDocument {(querySnapshot,error)in
            
            guard let document = querySnapshot else{
                print("no document for user")
                return
            }
            let result = Result{
                try? document.data(as: User.self)
            }
            switch result {
            case.success(let userObject):
                if let user=userObject{
                    saveUserLocally(user)
                }else{
                    print("Document does not exist")
                }
            case.failure(let error):
                print("error decoding user", error)
            }
        }
    }
}
