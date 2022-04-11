//
//  CommunityListViewModel.swift
//  Haro
//
//  Created by Shin Jae Ung on 2022/04/11.
//

import SwiftUI

class CommunityListViewModel: ObservableObject {
    let category: CommunityCategory
    @Published var entity: [CommunityEntity]?
    
    func text(of index: Int) -> String {
        guard let entity = self.entity else { return "" }
        return entity[index].text
    }
    
    func like(of index: Int) -> String {
        guard let entity = self.entity else { return "" }
        return String(entity[index].like)
    }
    
    func comment(of index: Int) -> String {
        guard let entity = self.entity else { return "" }
        return String(entity[index].comment.count)
    }
    
    init(_ category: CommunityCategory) {
        self.category = category
    }
    
    func configure() {
        guard let filePath = Bundle.main.path(forResource: category.rawValue, ofType: "json") else { return }
        guard let jsonString = try? String(contentsOfFile: filePath) else { return }
        guard let data = jsonString.data(using: .utf8) else { return }
        guard let communityEntity = try? JSONDecoder().decode([CommunityEntity].self, from: data) else { return }
        self.entity = communityEntity
    }
}
