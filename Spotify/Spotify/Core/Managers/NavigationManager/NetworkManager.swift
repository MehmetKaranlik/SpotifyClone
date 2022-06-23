//
//  NavigationManager.swift
//  Spotify
//
//  Created by mehmet karanlık on 24.06.2022.
//

import Foundation


struct NetworkManager : INetworkManager {

   var authManager: AuthManager

   func send<T>(
      networkPath: String,
      parseModel: T.Type,
      requestType: RequestType,
      body: [String : String]?,
      queryParameters: [String : String]?
   ) async -> BaseNetworkResponse<T> where T : Decodable, T : Encodable {

      guard var url = URL(string: networkPath) else { return  BaseNetworkResponse<T>(response: nil, data: nil) }
      var request = URLRequest(url: url)
      queryGenerator(requestURL: &url, queryParameters: queryParameters)
      headerGenerator(request: &request)
      bodyGenerator(request: &request, body: body)
      let (data,response) = await handleRequest(request: request) ?? (nil,nil)
      if let data {
         let decodedData = decodeData(data: data, parseModel: parseModel.self)
         return BaseNetworkResponse(response: response, data: decodedData)
      }
      return BaseNetworkResponse<T>(response: nil, data: nil)
   }



}
