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
      bodyType: BodyType,
      queryParameters: [String : String]?
   ) async -> BaseNetworkResponse<T> where T : Decodable, T : Encodable {

      guard var url = URL(string: networkPath) else { return  BaseNetworkResponse<T>(response: nil, data: nil) }
      print("Result : \(url)")
      var request = URLRequest(url: url)
      request.httpMethod = requestType.rawValue
      queryGenerator(requestURL: &url, queryParameters: queryParameters)
      headerGenerator(request: &request)
      bodyGenerator(request: &request, body: body,bodyType: bodyType)
      let (data,response) : (Data?,URLResponse?) = await handleRequest(request: request)
      let jsonData = try! JSONSerialization.jsonObject(with: data!)
      for i in jsonData as! Dictionary<String,AnyObject> {
         print("Result : \(i.key) : \(i.value)")
      }
      if let data {
         let decodedData = decodeData(data: data, parseModel: parseModel.self)
         return BaseNetworkResponse(response: response, data: decodedData)
      }
      return BaseNetworkResponse<T>(response: nil, data: nil)
   }


   func fetchAccessTokenByCode(code : String) async -> TokenResponseModel? {

      let result = try? await send(networkPath: NetworkPaths.exchangeTokenBaseUrl.rawValue,
                                   parseModel: TokenResponseModel.self,
                                   requestType: .POST,
                                   body: [
                                    "grant_type": "authorization_code",
                                    "code":code,
                                    "redirect_uri": AuthManager.Constants.redirectURI,
                                   ],
                                   bodyType: .MULTIFORM,
                                   queryParameters: nil)


      return result?.data
   }




   struct TokenResponseModel: Codable {
      let tokenType: String?
      let expiresIn: Int?
      let accessToken, refreshToken, scope: String?

      enum CodingKeys: String, CodingKey {
         case tokenType = "token_type"
         case expiresIn = "expires_in"
         case accessToken = "access_token"
         case refreshToken = "refresh_token"
         case scope
      }
   }

}
