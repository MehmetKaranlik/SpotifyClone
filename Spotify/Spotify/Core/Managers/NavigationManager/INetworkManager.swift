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

struct BaseNetworkResponse<T: Codable> {
   let response: URLResponse?
   let data: T?
}

protocol INetworkManager {
   var authManager: AuthManager { get set }
   func send<T: Codable>(
      networkPath: String,
      parseModel: T.Type,
      requestType: RequestType,
      body: [String: String]?,
      queryParameters: [String: String]?
   ) async -> BaseNetworkResponse<T>

   func headerGenerator(request: inout URLRequest)
   func bodyGenerator(request: inout URLRequest, body: [String: String]?)
   func queryGenerator(requestURL: inout URL, queryParameters: [String: String]?)
   func handleRequest(request: URLRequest) async -> (Data, URLResponse)?
   func decodeData<T: Codable>(data: Data, parseModel: T.Type) -> T?
}

extension INetworkManager {
   func headerGenerator(request: inout URLRequest) {
      Task { () -> [String: String] in
         let accessToken = await authManager.accesToken
         let headers = [
            "Authorization": "Bearer \(accessToken ?? "")",
            "ContentType": "Application/json"
         ]
         return headers
      }
   }

   func bodyGenerator(request: inout URLRequest, body: [String: String]?) {
      guard body != nil else { return }
      let data = try? JSONSerialization.data(withJSONObject: body!, options: .prettyPrinted)
      request.httpBody = data
   }

   func queryGenerator(requestURL: inout URL, queryParameters: [String: String]?) {
      guard queryParameters != nil else { return }
      var queries = [URLQueryItem]()
      queryParameters!.forEach {
         queries.append(URLQueryItem(name: $0, value: $1))
      }
      requestURL.append(queryItems: queries)
   }

   func handleRequest(request: URLRequest) async -> (Data, URLResponse)? {
      do {
         let (data, response) = try await URLSession.shared.data(for: request)
         return (data, response)
      } catch let e {
         print(e)
         return nil
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
}
