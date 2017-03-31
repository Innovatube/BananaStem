//
//  LoginPresenter.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/16/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation

protocol LoginPresenterInterface {
  func invalidEmail()
  func invalidPassword()
  func loginSuccess()
  func loginFailed()
}

class LoginPresenter: LoginPresenterInterface {
  var view : LoginViewInterface!
  var router : MainRouter!
  
  func invalidEmail(){
    view.raiseEmailFieldError()
  }
  func invalidPassword(){
    view.raisePasswordFieldError()
  }
  
  func loginSuccess(){
    router.displayListView()
  }
  func loginFailed(){
    view.displayErrorLoginMessage()
  }
}
