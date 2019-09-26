//
//  ViewController.swift
//  Firebase-Crashlytics-Sample
//
//  Created by Kazunori Aoki on 2019/09/26.
//  Copyright © 2019 kazua. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    let crashAddLog = CrashlyticsAddLoggin()
    
    @IBAction func tappedCrashButton() {
        
        Crashlytics.sharedInstance().crash()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setCrashlyticsLogs()
    }
    
    func setCrashlyticsLogs() {
        crashAddLog.setUdidForCrashlytics(udid: "12345")
        crashAddLog.setAppNoForCrashlytics(appNo: "hoge123")
        crashAddLog.setClassNameForCrashlytics(className: String(describing: type(of: self)))
        crashAddLog.setICardMemberForCrashlytics(isCardMember: true)
        crashAddLog.setShopCodeForCrashlytics(shopCode: "S090")
        crashAddLog.setRegistStoreNameForCrashlytics(registStore: "hogehoge店")
        crashAddLog.setIDsForCrashlytics(ids: "121212", idName: "Fuga")
    }
}
