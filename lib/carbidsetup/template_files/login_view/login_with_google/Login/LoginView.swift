//
//  LoginView.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/16/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import UIKit

protocol LoginViewInterface {
  func displayErrorLoginMessage()
  func raiseEmailFieldError()
  func raisePasswordFieldError()
}

class LoginView : UIViewController, LoginViewInterface, UITextFieldDelegate {
  var interactor : LoginInteractorInterface!
  
  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  
  
  @IBAction func loginButtonTouched(_ button: UIButton){
    guard let emailFieldText = emailField.text else {
      return
    }
    guard let passwordFieldText = passwordField.text else {
      return
    }
    interactor.login(email: emailFieldText, password: passwordFieldText)
  }
  
  @IBAction func registerButtonTouched(_ button: UIButton){
    interactor.register()
  }
  
  @IBAction func forgotPassword(_ button: UIButton){
    interactor.forgotPassword()
  }
  
  @IBAction func facebookLoginButtonTouched(_ button: UIButton){
    interactor.facebookLogin()
  }
  
  func raiseEmailFieldError() {
    
  }
  
  func raisePasswordFieldError() {
    
  }
  
  func displayErrorLoginMessage() {
    self.displayError(message: "Login error")
  }
}
