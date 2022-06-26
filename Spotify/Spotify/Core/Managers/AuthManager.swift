//
//  AuthController.swift
//  Spotify
//
//  Created by mehmet karanlık on 23.06.2022.
//

import Foundation

class AuthManager : NSObject {
   static let shared = AuthManager()
   @Published var accesToken: String? {
      didSet {
         cacheAccessToken()
      }
   }

   @Published var refreshToken: String? {
      didSet {
         cacheRefreshToken()
      }
   }

   override init() {

      self.accesToken = localeManager.getStringValue(key: LocaleKeys.ACCESS_TOKEN.rawValue)
      self.refreshToken = localeManager.getStringValue(key: LocaleKeys.REFRESH_TOKEN.rawValue)
      self.tokenExpirationData = localeManager.getDate(key: LocaleKeys.EXPIRATION_DATE.rawValue)

   }

   let localeManager: LocaleManager = .shared
   lazy var networkManager = NetworkManager(authManager: self)

   let queue = DispatchQueue(label: "queue", qos: .background,
                             attributes: .concurrent, autoreleaseFrequency: .inherit, target: .main)

   struct Constants {
      static let spotifyBaseURL: String = "https://accounts.spotify.com/authorize?"

      // generate modular scope
      static var spotifyScopes: String =  {
         var scopeString = String()
         Scopes.allCases.forEach {
            if $0 != Scopes.allCases.last {
               scopeString.append("\($0.rawValue)%20")
            }else { scopeString.append($0.rawValue) }
         }
         return scopeString
      }()

      static let clientID: String = "3cbad68b84604c298103b3be35ec3111"
      static let redirectURI: String = "https://github.com/MehmetKaranlik/SpotifyClone"
      static let clientSecret: String = "946a49a7af5e4447a84d48a220277659"
   }

   // possible scope types
   enum Scopes : String, CaseIterable {
      case user_read_private = "user-read-private"
      case playlist_modify_public = "playlist-modify-public"
      case playlist_read_private = "playlist-read-private"
      case playlist_modify_private = "playlist-modify-private"
      case user_follow_read = "user-follow-read"
      case user_library_modify = "user-library-modify"
      case user_library_read = "user-library-read"
      case user_read_email = "user-read-email"
   }

   public var signInURL: URL? {
      return URL(string: Utilities.spotifyOAuth2URLGenerator(baseUrl: Constants.spotifyBaseURL, clientID: Constants.clientID, scopes: Constants.spotifyScopes, redirectURI: Constants.redirectURI))
   }



   private var tokenExpirationData: Date? {
      didSet {
         cacheRefreshDate()
      }
   }

    var shouldRefreshToken: Bool {
      if tokenExpirationData != nil {

         return tokenExpirationData! < .now - 600
      }
      return true
   }

   public func excangeTokenWithCode(_ code: String, onComplete: @escaping (Bool) -> ()) async {
      let token = await networkManager.fetchAccessTokenByCode(code: code)
      if let token {
         queue.async {
            self.setAccestAccesToken(token.accessToken)
            self.setRefreshToken(token.refreshToken)
            self.setExpirationDate(token.expiresIn!)
         }
        return  onComplete(true)
      }
      return onComplete(false)
   }



   func authorizationSecretBase64() -> String? {
      let secretAuth: String = Constants.clientID+":"+Constants.clientSecret
      // converting base64
      let data = secretAuth.data(using: .utf8)
      let base64String = data?.base64EncodedString()
      guard base64String != nil else { return nil }
      return base64String!
   }

   // setters

    func setAccestAccesToken(_ newToken: String?) {
       guard newToken != nil else { return }
      queue.async {
         self.accesToken = newToken!
      }
   }

   private func setRefreshToken(_ newToken: String?) {
      guard newToken != nil else { return }
      queue.async {
         self.refreshToken = newToken!
      }
   }

   private func setExpirationDate( _ newDateInSeconds : Int) {
      print("Result : \(Date(timeInterval: TimeInterval(integerLiteral: Int64(newDateInSeconds)), since: .now))")
      queue.async {
         self.tokenExpirationData = Date(timeInterval: TimeInterval(integerLiteral: Int64(newDateInSeconds)), since: .now)
      }
   }



   // cachers
   private func cacheAccessToken() {
      accesToken != nil ? localeManager.setStringValue(key: LocaleKeys.ACCESS_TOKEN.rawValue, value: accesToken!) : nil
   }

   private func cacheRefreshToken() {
      refreshToken !=  nil ?  localeManager.setStringValue(key: LocaleKeys.REFRESH_TOKEN.rawValue, value: refreshToken!) : nil
   }

   private func cacheRefreshDate() {

         tokenExpirationData != nil ?
         localeManager.setDateValue(
            key: LocaleKeys.EXPIRATION_DATE.rawValue,
            value: tokenExpirationData!)
      
         : nil

   }
}
