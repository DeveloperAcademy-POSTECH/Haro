//
//  StoryCategory.swift
//  Haro
//
//  Created by Moon Jongseek on 2022/04/10.
//

import Foundation

enum StoryMainCategory: CaseIterable {
    case place, news, event, accident
    
    var title: String {
        switch self {
        case .place: return "추천장소"
        case .news: return "가게소식"
        case .event: return "행사축제"
        case .accident: return "사건사고"
        }
    }
    
    var imageName: String {
        switch self {
        case .place: return "place"
        case .news: return "news"
        case .event: return "event"
        case .accident: return "accident"
        }
    }
}

enum StoryCategory: CaseIterable {
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
    
    var rawString: String {
        switch self {
        case .cafe: return "cafe"
        case .restaurant: return "restaurant"
        case .culture: return "culture"
        case .cloth: return "cloth"
        case .promenade: return "promenade"
        case .park: return "park"
        case .mart: return "mart"
        case .facility: return "facility"
        case .otherPlace: return "otherPlace"
            
        case .opening: return "opening"
        case .notice: return "notice"
        case .discount: return "discount"
        case .otherNews: return "otherNews"
            
        case .event: return "event"
        case .festival: return "festival"
        case .animal: return "animal"
        case .otherEvent: return "otherEvent"
            
        case .traffic: return "traffic"
        case .crime: return "crime"
        case .construction: return "construction"
        case .otherAccident: return "otherAccident"
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
