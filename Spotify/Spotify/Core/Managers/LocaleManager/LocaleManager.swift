//
//  LocaleManager.swift
//  Spotify
//
//  Created by mehmet karanlık on 24.06.2022.
//

import Foundation


struct LocaleManager : ILocaleManager {

   var userDefaults: UserDefaults = UserDefaults.standard
   static let shared = LocaleManager()
   private init(){}

   func setStringValue(key: LocaleKeys.RawValue, value: String) {
      userDefaults.set(value, forKey: key)
   }

   func setBoolValue(key: LocaleKeys.RawValue, value: Bool) {
      userDefaults.set(value, forKey: key)

   }

   func setIntValue(key: LocaleKeys.RawValue, value: Int) {
      userDefaults.set(value, forKey: key)

   }

   func getStringValue(key: LocaleKeys.RawValue) -> String? {
      return userDefaults.string(forKey: key)
   }

   func getBoolValue(key: LocaleKeys.RawValue) -> Bool? {
      return userDefaults.bool(forKey: key)

   }

   func getIntValue(key: LocaleKeys.RawValue) -> Int? {
      return userDefaults.integer(forKey: key)

   }


}
