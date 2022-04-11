//
//  LoginPageViewModel.swift
//  Haro
//
//  Created by kelly on 2022/04/11.
//

import SwiftUI

class LoginPageViewModel: ObservableObject{
    @Published var email = ""
    @Published var pwd = ""
}
