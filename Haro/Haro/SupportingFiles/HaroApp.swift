//
//  HaroApp.swift
//  Haro
//
//  Created by Shin Jae Ung on 2022/04/06.
//

import SwiftUI

@main
struct HaroApp: App {
    let login = UserDefaults.standard.bool(forKey: "token")
    
    var body: some Scene {
        WindowGroup {
            if login {
                MainView()
            } else {
                LoginPageView()
            }
        }
    }
}
