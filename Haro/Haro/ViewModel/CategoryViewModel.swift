//
//  CategoryViewModel.swift
//  Haro
//
//  Created by Shin Jae Ung on 2022/04/07.
//

import Foundation
import SwiftUI

class CategoryViewModel: ObservableObject {
    @Published var selectedMainCategory = CommunityMainCategory.meeting
    var mainCategories: [CommunityMainCategory] {
        return CommunityMainCategory.allCases
    }
    var categories: [CommunityCategory] {
        return CommunityCategory.inside(of: self.selectedMainCategory)
    }
    var colors: [Color] {
        return [
            Color.init(red: 234/255, green: 246/255, blue: 146/255),
            Color.init(red: 196/255, green: 197/255, blue: 251/255),
            Color.init(red: 164/255, green: 225/255, blue: 250/255),
            Color.init(red: 255/255, green: 214/255, blue: 120/255),
            Color.init(red: 136/255, green: 156/255, blue: 242/255),
            Color.init(red: 254/255, green: 156/255, blue: 119/256),
            Color.green
        ]
    }
}

