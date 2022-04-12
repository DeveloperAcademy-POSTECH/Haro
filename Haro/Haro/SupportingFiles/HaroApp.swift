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
            MainView()
//            if login {
//                MainView()
//            } else {
//                LoginPageView()
//            }
        }
    }
}


struct TestView: View {
    @State var string0 = "STring"
    var body: some View {
        Text("\(self.string0)")
        Button("Chang") {
            self.string0 = "asdfasdf"
        }
    }
}
