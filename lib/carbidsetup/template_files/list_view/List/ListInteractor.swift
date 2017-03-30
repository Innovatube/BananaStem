//
//  ListInteractor.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/21/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation

protocol ListInteractorInterface {
  func requestReloadData()
}

class ListInteractor : ListInteractorInterface {
    var presenter : ListPresenterInterface!
  func requestReloadData() {
    presenter.reload(data: [])
  }
}
