//
//  INavigationManager.swift
//  Spotify
//
//  Created by mehmet karanlık on 24.06.2022.
//

import Foundation

enum RequestType: String {
   case GET
   case POST
   case DELETE
   case PUT
}

enum BodyType {
   case JSON
   case MULTIFORM
}

struct BaseNetworkResponse<T: Codable> {
   let response: URLResponse?
   let data: T?
}

protocol INetworkManager {
   var authManager: AuthManager? { get set }
   func send<T: Codable>(
      networkPath: String,
      parseModel: T.Type,
      requestType: RequestType,
      body: [String: String]?,
      bodyType: BodyType,
      queryParameters: [String: String]?
   ) async -> BaseNetworkResponse<T>

   func headerGenerator(request: inout URLRequest)
   func bodyGenerator(request: inout URLRequest, body: [String: String]?, bodyType:  BodyType)
   func queryGenerator(requestURL: inout URL, queryParameters: [String: String]?)
   func handleRequest(request: URLRequest) async -> (Data?, URLResponse?)
   func decodeData<T: Codable>(data: Data, parseModel: T.Type) -> T?
}

extension INetworkManager {
   func headerGenerator(request: inout URLRequest) {
         let accessToken =  authManager?.authorizationSecretBase64()
         guard accessToken != nil else { return }
         let headers = [
            "Authorization": "Basic \(accessToken!)",
            "ContentType": "application/x-www-form-urlencoded"
         ]

         request.allHTTPHeaderFields = headers
   }

   func bodyGenerator(request: inout URLRequest, body: [String: String]?, bodyType:  BodyType) {
      guard body != nil else { return }
      if bodyType == .JSON {
         let data = try? JSONSerialization.data(withJSONObject: body!, options: .prettyPrinted)
         request.httpBody = data
      }else {
         var components = URLComponents()
         var queryItems = [URLQueryItem]()
         body?.forEach{ queryItems.append(URLQueryItem(name: $0, value: $1))  }
         components.queryItems = queryItems
         request.httpBody = components.query?.data(using: .utf8)

      }
   }

   func queryGenerator(requestURL: inout URL, queryParameters: [String: String]?) {
      guard queryParameters != nil else { return }
      var queries = [URLQueryItem]()
      queryParameters!.forEach { queries.append(URLQueryItem(name: $0, value: $1)) }
      requestURL.append(queryItems: queries)
   }

   func handleRequest(request: URLRequest) async -> (Data?, URLResponse?) {
      do {
         let (data, response) = try await URLSession.shared.data(for: request)
         return (data, response)
      } catch let e {
         print(e)
         return (nil,nil)
      }
   }

   func decodeData<T: Codable>(data: Data, parseModel: T.Type) -> T? {
      do {
         let data = try JSONDecoder().decode(T.self, from: data)
         return data
      } catch let e {
         print(e)
         return nil
      }
   }

   func fetchAccessTokenByRefreshToken<T: Codable>(_ refreshToken : String) async -> T? {

      let result = await send(
         networkPath: "",
         parseModel: T.self,
         requestType: .GET,
         body: [
            "grant_type": "refresh_token",
            "refresh_token": refreshToken
         ],
         bodyType: .JSON,
         queryParameters: nil)
      return nil
   }
}
