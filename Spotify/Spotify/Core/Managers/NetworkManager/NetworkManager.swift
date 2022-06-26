   //
   //  NavigationManager.swift
   //  Spotify
   //
   //  Created by mehmet karanlık on 24.06.2022.
   //

import Foundation


struct NetworkManager : INetworkManager {

   weak var authManager: AuthManager?

   func send<T>(
      networkPath: String,
      parseModel: T.Type,
      requestType: RequestType,
      body: [String : String]?,
      headerType: HeaderType?,
      bodyType: BodyType,

      queryParameters: [String : String]?
   ) async -> BaseNetworkResponse<T> where T : Decodable, T : Encodable {

      guard var url = URL(string: networkPath) else { return  BaseNetworkResponse<T>(response: nil, data: nil) }
      print("Result : \(url)")
      var request = URLRequest(url: url)
      request.httpMethod = requestType.rawValue
      request.timeoutInterval = 15
      queryGenerator(requestURL: &url, queryParameters: queryParameters)
      headerGenerator(request: &request,headerType: headerType ?? .NONE)
      bodyGenerator(request: &request, body: body,bodyType: bodyType)
      let (data,response) : (Data?,URLResponse?) = await handleRequest(request: request)
      if let data {
         let decodedData = decodeData(data: data, parseModel: parseModel.self)
         await handleRefreshToken(refreshToken: authManager?.refreshToken)
         return BaseNetworkResponse(response: response, data: decodedData)
      }
      return BaseNetworkResponse<T>(response: nil, data: nil)
   }


   func fetchAccessTokenByCode(code : String) async -> TokenResponseModel? {
      let result = await send(
         networkPath: NetworkPaths.exchangeTokenBaseUrl.rawValue,
         parseModel: TokenResponseModel.self,
         requestType: .POST,
         body: [
            "grant_type": "authorization_code",
            "code":code,
            "redirect_uri": AuthManager.Constants.redirectURI
         ],
         headerType: .CODE,
         bodyType: .MULTIFORM,
         queryParameters: nil)

      return result.data
   }


   func handleRefreshToken(refreshToken : String?) async -> Void {
      guard authManager != nil, authManager!.shouldRefreshToken == true else { return }
      guard authManager!.refreshToken != nil else { return }
      let result = await fetchAccessTokenByRefreshToken(refreshToken!) as TokenResponseModel?
      guard result?.accessToken != nil else { return }
      authManager?.setAccestAccesToken(result!.accessToken!)
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
