//
//  LoginInteractor.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/16/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation

protocol LoginInteractorInterface {
  func login(email: String, password: String)
  func forgotPassword()
  func register()
  func googleSignIn()
}

class LoginInteractor : LoginInteractorInterface {
    var presenter : LoginPresenterInterface!
  
  func login(email: String, password: String){
    presenter.loginSuccess()
  }
  
  func register() {
  }
  
  func forgotPassword() {
  }
  
  func googleSignIn() {
  }
}
