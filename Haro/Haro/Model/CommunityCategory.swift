//
//  CommunityCategory.swift
//  Haro
//
//  Created by Shin Jae Ung on 2022/04/08.
//

import Foundation


enum CommunityMainCategory: CaseIterable {
    case meeting, place, news, event, accident
    
    var title: String {
        switch self {
        case .meeting: return "소모임"
        case .place: return "장소"
        case .news: return "소식"
        case .event: return "이벤트"
        case .accident: return "사건사고"
        }
    }
}

enum CommunityCategory {
    case totalMeeting, humanity, exercise, instrument, travel, otherMeeting,
         totalPlace, restaurant, culture, cloth, promenade, mart, otherPlace,
         totalNews, opening, notice, discount, otherNews,
         totalEvent, event, festival, animal, otherEvent,
         totalAccident, traffic, crime, construction, otherAccident
    
    static func inside(of main: CommunityMainCategory) -> [CommunityCategory] {
        switch main {
        case .meeting: return [totalMeeting, humanity, exercise, instrument, travel, otherMeeting]
        case .place: return [totalPlace, restaurant, culture, cloth, promenade, mart, otherPlace]
        case .news: return [totalNews, opening, notice, discount, otherNews]
        case .event: return [totalEvent, event, festival, animal, otherEvent]
        case .accident: return [totalAccident, traffic, crime, construction, otherAccident]
        }
    }
    
    var text: String {
        switch self {
        case .totalMeeting: return "전체"
        case .humanity: return "인문 교양"
        case .exercise: return "체육"
        case .instrument: return "악기 연주"
        case .travel: return "여행"
        case .otherMeeting: return "기타"
        case .totalPlace: return "전체"
        case .restaurant: return "카페 / 식당"
        case .culture: return "문화생활"
        case .cloth: return "옷가게"
        case .promenade: return "산책로 / 공원"
        case .mart: return "마트"
        case .otherPlace: return "기타"
        case .totalNews: return "전체"
        case .opening: return "신장개업"
        case .notice: return "가게공지"
        case .discount: return "할인행사"
        case .otherNews: return "기타"
        case .totalEvent: return "전체"
        case .event: return "행사"
        case .festival: return "축제"
        case .animal: return "귀여운 동물 출몰"
        case .otherEvent: return "기타"
        case .totalAccident: return "전체"
        case .traffic: return "교통상황"
        case .crime: return "범죄 / 화재"
        case .construction: return "공사중"
        case .otherAccident: return "기타"
        }
    }
}
