//
//  ILocaleManager.swift
//  Spotify
//
//  Created by mehmet karanlık on 24.06.2022.
//

import Foundation



protocol ILocaleManager {

   var userDefaults : UserDefaults { get }

   func clearAllCaches()

   func setStringValue(key : LocaleKeys.RawValue,value : String)
   func setBoolValue(key : LocaleKeys.RawValue,value : Bool)
   func setIntValue(key : LocaleKeys.RawValue,value : Int)

   func getStringValue(key: LocaleKeys.RawValue) -> String?
   func getBoolValue(key: LocaleKeys.RawValue)-> Bool?
   func getIntValue(key: LocaleKeys.RawValue)-> Int?
   

}

extension ILocaleManager {
   func clearAllCaches() {
      guard let bundleID = Bundle.main.bundleIdentifier else { return }
      UserDefaults.standard.removePersistentDomain(forName: bundleID)
      sync()
   }
}
