//
//  SignUpPageViewModel.swift
//  Haro
//
//  Created by kelly on 2022/04/11.
//

import SwiftUI

class SignUpPageViewModel: ObservableObject{
    @Published var nickName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var passwordConfirm = ""
    
    var isValidName: Bool {
        let pattern = "^[a-zA-Z0-9]{5,20}$"
        let regex = try? NSRegularExpression(pattern: pattern)
        if let _ = regex?.firstMatch(in: self.nickName, options: [], range: NSRange(location: 0, length: self.nickName.count)) {
            return true
        } else {
            return false
        }
    }
    
    var isValidEmail: Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let regex = try? NSRegularExpression(pattern: pattern)
        if let _ = regex?.firstMatch(in: self.email, options: [], range: NSRange(location: 0, length: self.email.count)) {
            return true
        } else {
            return false
        }
    }
    
    var isValidPassword: Bool {
        let pattern = "^[A-Z, a-z, 0-9, [!@#$%^&*()_+=?<>,.`~;':\"{}|\\]\\[-]]+.{8,16}$"
        let regex = try? NSRegularExpression(pattern: pattern)
        if let _ = regex?.firstMatch(in: self.password, options: [], range: NSRange(location: 0, length: self.password.count)) {
            return true
        } else {
            return false
        }
    }
    
    var isValidPasswordConfirm: Bool {
        return password == passwordConfirm
    }
    
    var isSignUpPossible: Bool {
        return isValidName && isValidEmail && isValidPassword && isValidPasswordConfirm
    }
}
