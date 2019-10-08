//
//  CrashlyticsAddLogging.swift
//  Firebase-Crashlytics-Sample
//
//  Created by Kazunori Aoki on 2019/09/26.
//  Copyright © 2019 kazua. All rights reserved.
//

import Foundation
import Firebase

class CrashlyticsAddLoggin {
    
    func setCrashUserIdentifier() {
        Crashlytics.sharedInstance().setUserIdentifier("任意のユーザIDをセットする")
    }
    
    func setCrashUserName() {
        Crashlytics.sharedInstance().setUserName("ユーザネームなど")
    }
    
    func setCrashEmailAddress() {
        Crashlytics.sharedInstance().setUserEmail("Emailアドレスなど")
    }
    
    func setCrashIntValue(forKey: String, value: Int32) {
        Crashlytics.sharedInstance().setIntValue(value, forKey: forKey)
    }
    
    func setCrashStringValue(forKey: String, value: String) {
        Crashlytics.sharedInstance().setObjectValue(value, forKey: forKey)
    }
    
    // 以下 使用例
    func setUdidForCrashlytics(udid: String) {
        if !udid.isEmpty {
            Crashlytics.sharedInstance().setUserIdentifier("udid: " + udid)
        }
    }
    
    func setAppNoForCrashlytics(appNo: String) {
        if !appNo.isEmpty {
            Crashlytics.sharedInstance().setUserName("appNo: " + appNo)
        }
    }
    
    func setClassNameForCrashlytics(className: String) {
        if !className.isEmpty {
            Crashlytics.sharedInstance().setObjectValue(className, forKey: "ClassName: ")
        }
    }
    
    func setICardMemberForCrashlytics(isCardMember: Bool = false) {
        
        var cardMember = ""
        if isCardMember == true {
            cardMember = "ログイン済み"
        } else {
            cardMember = "未ログイン"
        }
        Crashlytics.sharedInstance().setObjectValue(cardMember, forKey: "IsCardMember: ")
    }
    
    func setShopCodeForCrashlytics(shopCode: String) {
        if !shopCode.isEmpty {
            Crashlytics.sharedInstance().setObjectValue(shopCode, forKey: "ShopCode: ")
        }
    }
    
    func setRegistStoreNameForCrashlytics(registStore: String) {
        if !registStore.isEmpty {
            Crashlytics.sharedInstance().setObjectValue(registStore, forKey: "RegistStore: ")
        }
    }
    
    func setIDsForCrashlytics(ids: String, idName: String) {
        if !ids.isEmpty {
            Crashlytics.sharedInstance().setObjectValue(ids, forKey: "\(idName): ")
        }
    }
}
