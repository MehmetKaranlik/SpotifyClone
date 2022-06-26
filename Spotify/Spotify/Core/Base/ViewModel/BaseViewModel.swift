//
//  BaseViewModel.swift
//  Spotify
//
//  Created by mehmet karanlık on 26.06.2022.
//

import Foundation


class BaseViewModel : ObservableObject {

   static let authManager : AuthManager = AuthManager.shared
   let networkManager = NetworkManager(authManager: authManager)
}
