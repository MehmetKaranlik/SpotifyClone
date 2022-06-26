//
//  UserModel.swift
//  Spotify
//
//  Created by mehmet karanlık on 27.06.2022.
//

import Foundation

   // MARK: - User
struct User: Codable {
   let country, displayName, email: String?
   let explicitContent: ExplicitContent?
   let externalUrls: ExternalUrls?
   let followers: Followers?
   let href, id: String?
   let images: [Image]?
   let product, type, uri: String?

   enum CodingKeys: String, CodingKey {
      case country
      case displayName = "display_name"
      case email
      case explicitContent = "explicit_content"
      case externalUrls = "external_urls"
      case followers, href, id, images, product, type, uri
   }
}

   // MARK: - ExplicitContent
struct ExplicitContent: Codable {
   let filterEnabled, filterLocked: Bool?

   enum CodingKeys: String, CodingKey {
      case filterEnabled = "filter_enabled"
      case filterLocked = "filter_locked"
   }
}

   // MARK: - ExternalUrls
struct ExternalUrls: Codable {
   let spotify: String?
}

   // MARK: - Followers
struct Followers: Codable {
   let href: String?
   let total: Int?
}

   // MARK: - Image
struct Image: Codable {
   let url: String?
   let height, width: Int?
}
