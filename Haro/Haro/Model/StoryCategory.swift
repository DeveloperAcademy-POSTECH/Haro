//
//  StoryCategory.swift
//  Haro
//
//  Created by Moon Jongseek on 2022/04/10.
//

import Foundation

enum StoryMainCategory: String, CaseIterable {
    case place, news, event, accident
    
    var title: String {
        switch self {
        case .place: return "장소"
        case .news: return "소식"
        case .event: return "이벤트"
        case .accident: return "사건사고"
        }
    }
}

enum StoryCategory: String, CaseIterable {
    case cafe, restaurant, culture, cloth, promenade, park, facility, mart, otherPlace,
         opening, notice, discount, otherNews,
         event, festival, animal, otherEvent,
         traffic, crime, construction, otherAccident
    
    static func inside(of main: StoryMainCategory) -> [StoryCategory] {
        switch main {
        case .place: return [cafe, restaurant, culture, cloth, promenade, park, mart, facility, otherPlace]
        case .news: return [opening, notice, discount, otherNews]
        case .event: return [event, festival, animal, otherEvent]
        case .accident: return [traffic, crime, construction, otherAccident]
        }
    }
    
    var main: StoryMainCategory {
        switch self {
        case .cafe: fallthrough
        case .restaurant: fallthrough
        case .culture: fallthrough
        case .cloth: fallthrough
        case .promenade: fallthrough
        case .park: fallthrough
        case .facility: fallthrough
        case .mart: fallthrough
        case .otherPlace: return .place
        case .opening: fallthrough
        case .notice: fallthrough
        case .discount: fallthrough
        case .otherNews: return .news
        case .event: fallthrough
        case .festival: fallthrough
        case .animal: fallthrough
        case .otherEvent: return .event
        case .traffic: fallthrough
        case .crime: fallthrough
        case .construction: fallthrough
        case .otherAccident: return .accident
        }
    }
    
    var text: String {
        switch self {
        case .cafe: return "카페"
        case .restaurant: return "식당"
        case .culture: return "문화생활"
        case .cloth: return "옷가게"
        case .promenade: return "산책로"
        case .park: return "공원"
        case .mart: return "마트"
        case .facility: return "공공시설"
        case .otherPlace: return "기타"
        case .opening: return "신장개업"
        case .notice: return "가게공지"
        case .discount: return "할인행사"
        case .otherNews: return "기타"
            
        case .event: return "행사"
        case .festival: return "축제"
        case .animal: return "동물 출몰"
        case .otherEvent: return "기타"
            
        case .traffic: return "교통상황"
        case .crime: return "범죄 / 화재"
        case .construction: return "공사중"
        case .otherAccident: return "기타"
        }
    }
}
