//
//  CategoryViewModel.swift
//  Haro
//
//  Created by Shin Jae Ung on 2022/04/07.
//

import Foundation

class CategoryViewModel: ObservableObject {
    @Published var selectedCategory = MainCategory.meeting
    
    enum MainCategory: CaseIterable {
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
        
        var contents: [String] {
            switch self {
            case .meeting: return ["전체", "인문 교양", "체육", "악기 연주"]
            case .place: return ["카페 / 식당", "문화생활", "옷가게", "산책로 / 공원", "마트"]
            case .news: return ["신장개업", "가게공지", "할인행사", "기타"]
            case .event: return ["행사", "축제", "귀여운 동물 출몰", "기타"]
            case .accident: return ["교통 상황", "범죄 / 화제", "공사중", "기타"]
            }
        }
    }
}
