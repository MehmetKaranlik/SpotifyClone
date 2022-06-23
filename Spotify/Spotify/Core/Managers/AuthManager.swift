//
//  AuthController.swift
//  Spotify
//
//  Created by mehmet karanlık on 23.06.2022.
//

import Foundation


actor AuthManager {

   
   @Published var accesToken : String?
   @Published var refreshToken : String?




   private struct Constants {
      static let spotifyBaseUrl : String = "https://accounts.spotify.com/authorize?"
      static let spotifyScopes : String = "user-read-private"
      static let clientID : String = "3cbad68b84604c298103b3be35ec3111"
      static let redirectURI : String = "https://github.com/MehmetKaranlik/SpotifyClone"


   }

   public var signInUrl : URL? {
      return URL(string: Utilities.spotifyOAuth2URLGenerator(baseUrl: Constants.spotifyBaseUrl, clientID: Constants.clientID, scopes: Constants.spotifyScopes, redirectURI: Constants.redirectURI))

   }

   func fetchAccesToken() -> String? {
      return accesToken
   }

   func updateAccessToken(_ newToken : String) {
      accesToken = newToken
   }

   private var tokenExpirationData : Date? {
      return nil
   }

   private var shouldRefreshToken: Bool {
      return false
   }

   public func excangeTokenWithCode(_ code: String) {
      
   }



}
