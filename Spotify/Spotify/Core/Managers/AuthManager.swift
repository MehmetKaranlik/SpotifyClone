//
//  AuthController.swift
//  Spotify
//
//  Created by mehmet karanlık on 23.06.2022.
//

import Foundation


class AuthManager {

   static let shared = AuthManager()
   @Published var accesToken : String?
   @Published var refreshToken : String?

   let localeManager : LocaleManager = LocaleManager.shared
   lazy var networkManager = NetworkManager(authManager: self)

   let queue = DispatchQueue(label: "queue", qos: .background,
                             attributes: .concurrent, autoreleaseFrequency: .inherit, target: .main)

    struct Constants {
      static let spotifyBaseUrl : String = "https://accounts.spotify.com/authorize?"
      static let spotifyScopes : String = "user-read-private"
      static let clientID : String = "3cbad68b84604c298103b3be35ec3111"
      static let redirectURI : String = "https://github.com/MehmetKaranlik/SpotifyClone"
       static let clientSecret : String = "946a49a7af5e4447a84d48a220277659"


   }

   public var signInUrl : URL? {
      return URL(string: Utilities.spotifyOAuth2URLGenerator(baseUrl: Constants.spotifyBaseUrl, clientID: Constants.clientID, scopes: Constants.spotifyScopes, redirectURI: Constants.redirectURI))

   }

   func fetchAccesToken() -> String? {
         return accesToken
   }

   func updateAccessToken(_ newToken : String) {
      queue.async {
         self.accesToken = newToken
      }
   }

   private var tokenExpirationData : Date? {
      return nil
   }

   private var shouldRefreshToken: Bool {
      return false
   }

   public func excangeTokenWithCode(_ code: String, onComplete : @escaping (Bool) -> ()) async {
      let token = await networkManager.fetchAccessTokenByCode(code: code)
      print("Result : \(token!.accessToken!)")
      queue.async {
         
      }
   }


   private func cacheToken() {
      localeManager.setStringValue(key: LocaleKeys.ACCESS_TOKEN.rawValue, value: accesToken!)
   }

   func authorizationSecretBase64() -> String? {
      let secretAuth : String = Constants.clientID+":"+Constants.clientSecret
      //converting base64
      let data = secretAuth.data(using: .utf8)
      let base64String = data?.base64EncodedString()
      guard base64String != nil else { return nil }
      return base64String!
   }












}
