//
//  ListPresenter.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/21/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation

protocol ListPresenterInterface {
  func reload(data: [String])
}

class ListPresenter: ListPresenterInterface {
  var view : ListViewInterface!
  var router : MainRouter!
  func reload(data: [String]) {
    view.reloadWith(data: data)
  }
}
