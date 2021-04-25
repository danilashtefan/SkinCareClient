//
//  ViewController.swift
//  StoryBoardProject
//
//  Created by Danil Stefaniuc on 13.03.2021.
//

import UIKit
import ProgressHUD
import SwiftUI

class LoginViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

 
    @IBOutlet weak var imageViewDownload: UIImageView!
    @IBOutlet weak var labelDownload: UILabel!
    @IBOutlet weak var loginTextField: UIButton!
    @IBOutlet weak var accountQuestionLabel: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var repeatPswdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var DontHavePasswordLabel: UILabel!
    
    var isLogin = true
    
    var pressCounter=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional up after loading the view.
        updateUIFor(login: true)
      
    }
    
    //MARK: -IBActions
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        
//        let mainView = UIHostingController(rootView: ContentView())
//        mainView.modalPresentationStyle = .fullScreen
//        self.present(mainView, animated: true, completion: nil)
        
        isLogin ? loginUser() : registerUser()
       
    }
    
    @IBAction func forgotPswdBtnPressed(_ sender: Any) {
        
        if isDataInputed(type: "password"){
            resetPassword()
            
        }
        else{
            ProgressHUD.showFailed("Email is required.")
        }
    }
    @IBAction func signUpBtnPressed(_ sender: Any) {
        isLogin = !isLogin
        pressCounter+=1
        if(pressCounter%2==0)
        {updateUIFor(login:true)}
        else {updateUIFor(login:false)}
    }
    
    // MARK: Animations
    private func updateUIFor(login:Bool){
       
        loginTextField.setImage(UIImage(named: login ? "loginBtn":"registerBtn"), for: .normal)
        
        signUpBtn.setTitle(login ? "Sign Up":"Sign In", for: .normal)
        
        DontHavePasswordLabel.text = login ? "Don't have account?": "Have a account?"
        
        UIView.animate(withDuration: 0.5){
            self.repeatPswdTextField.isHidden = login
            self.repeatPswdTextField.isHidden = login
            self.repeatPswdTextField.isHidden = login
            
        }
    }
    private func setUpBackgroundTap(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func backgroundTap(){
        view.endEditing(false)
    }
    
    
    //MARK: Helpers
    
    private func isDataInputed (type:String)->Bool{
        switch type {
        case "login":
            return emailTextField?.text != "" && passwordTextField?.text != ""
        case "registration":
            return emailTextField?.text != "" && passwordTextField?.text != "" && repeatPswdTextField?.text != ""
        default:
           return emailTextField?.text != ""
        }
    }
    
    private func  loginUser(){
        
        FirebaseUserListener.shared.loginUserWithEmail(email: emailTextField.text!, password: passwordTextField.text!){(error, isEmailVerified) in
            
            if error==nil{
                if isEmailVerified{
                    self.goToApp()
                }else{
                    ProgressHUD.showFailed("Please, verify email.")
                }
            }else{
                ProgressHUD.showFailed(error?.localizedDescription)
            }
            
        }
    }
    private func registerUser(){
        if passwordTextField.text! == repeatPswdTextField.text!{
            FirebaseUserListener.shared.registerUserWith(email: emailTextField.text!, password: passwordTextField.text!){(error) in
                if error==nil{
                    ProgressHUD.showSuccess("Verification email sent.")
                
                } else{
                    ProgressHUD.showFailed(error!.localizedDescription)
                }
            }
        }else{
            ProgressHUD.showFailed("Passwords don't match")
        }
        
    }
    
    //MARK: -Navigation
    
    private func goToApp(){
        
        let mainView = UIHostingController(rootView: ContentView())
        mainView.modalPresentationStyle = .fullScreen
        self.present(mainView, animated: true, completion: nil)
        
        
    }
    
    private func resetPassword(){
        FirebaseUserListener.shared.resetPasswordFor(email: emailTextField.text!){
            (error) in
            
            if error == nil{
                ProgressHUD.showSuccess("Reset link sent to email")
            }else{
                ProgressHUD.showFailed(error?.localizedDescription)
            }
        }
    }
}

