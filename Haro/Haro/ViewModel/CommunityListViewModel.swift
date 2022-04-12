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
    @Published var meetingEntity: [CommunityMeetingEntity]?
    
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
        if CommunityCategory.inside(of: .meeting).contains(where: { $0 == category }) {
            guard let communityMeetingEntity = try? JSONDecoder().decode([CommunityMeetingEntity].self, from: data) else { return }
            self.meetingEntity = communityMeetingEntity
        } else {
            guard let communityEntity = try? JSONDecoder().decode([CommunityEntity].self, from: data) else { return }
            self.entity = communityEntity
        }
    }
    
    func title(of index: Int) -> String {
        guard let meetingEntity = meetingEntity else { return "" }
        return meetingEntity[index].title
    }
    
    func descript(of index: Int) -> String {
        guard let meetingEntity = meetingEntity else { return "" }
        return meetingEntity[index].descript
    }
    
    func attendee(of index: Int) -> String {
        guard let meetingEntity = meetingEntity else { return "" }
        return meetingEntity[index].attendee
    }
}
