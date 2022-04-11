//
//  SelectCategoryView.swift
//  Haro
//
//  Created by Moon Jongseek on 2022/04/06.
//

import SwiftUI
import CoreLocationUI

struct SelectCategoryView: View {
    @State var imageName: String = "location"
    @State var selectedFirstCategory: StoryMainCategory?
    @State var navigationLinkIsActive: Bool = false
    
    let screenSize = UIScreen.main.bounds.size
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    func navigationTitleView(selectedFirstCategory: StoryMainCategory?) -> some View {
        if selectedFirstCategory == nil {
            return AnyView(
                Text("받고싶은 소식 선택")
                    .font(.system(size: 18, weight: .bold, design: .default))
            )
        } else {
            return AnyView(
                Button {
                    self.selectedFirstCategory = nil
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text(selectedFirstCategory?.title ?? "")
                            .font(.system(size: 18, weight: .bold, design: .default))
                        Spacer()
                    }
                }
                    .foregroundColor(.black)
                
            )
        }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.white)
                .shadow(color: .gray.opacity(0.5), radius: 2, x: 0, y: -2)
            VStack(alignment: .center) {
                self.navigationTitleView(selectedFirstCategory: self.selectedFirstCategory)
                    .padding([.top], 35)
                    .frame(width: self.screenSize.width * 0.85, alignment: .leading)
                if self.selectedFirstCategory == nil {
                    SelectFirstCategoryView(selectedFirstCategory: self.$selectedFirstCategory)
                        .frame(width: self.screenSize.width * 0.85)
                } else {
                    SelectSecondCategoryView(secondCategory: StoryCategory.inside(of: self.selectedFirstCategory ?? .place) )
                        .frame(width: self.screenSize.width * 0.85)
                }
                //                NavigationView {
                //                    VStack {
                //                        Rectangle()
                //                            .frame(height: 0)
                //                        ForEach(0..<self.firstCategory.count) { index in
                //                            NavigationLink(isActive: self.$navigationLinkIsActive) {
                //                                SelectSecondCategoryView(selectedFirstCategory: self.selectedFirstCategory)
                //                                    .onAppear {
                //                                        self.selectedFirstCategory = self.firstCategory[index]
                //                                    }
                //                            } label: {
                //                                Text(self.firstCategory[index])
                //                                    .font(.system(size: 16, weight: .regular, design: .default))
                //                                    .foregroundColor(.black)
                //                                    .frame(width: self.screenSize.width * 0.85 - 15, alignment: .leading)
                //                                    .padding(.leading, 15)
                //                            }
                //                            .onAppear {
                //                                self.selectedFirstCategory = ""
                //                            }
                //                            .padding(.bottom, 5)
                //                            .padding(.top, 5)
                //                            Rectangle()
                //                                .fill(.gray.opacity(0.6))
                //                                .frame(width: self.screenSize.width * 0.85, height: 1)
                //                        }
                //                        .frame(width: self.screenSize.width)
                //                        Spacer()
                //                    }
                //                    .navigationBarHidden(true)
                //                    .toolbar {
                //                        ToolbarItem(placement: .principal) {
                //                            Text("받고싶은 소식 선택").font(.headline)
                //                                .font(.system(size: 18, weight: .bold, design: .default))
                //                                .padding([.top])
                //                                .frame(width: self.screenSize.width * 0.85, alignment: .leading)
                //                        }
                //                    }
                //                }
                //                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous) )
                
                Rectangle()
                    .fill(.white)
            }
        }
        .frame(height: self.screenSize.height * 0.45)
    }
}

struct SelectFirstCategoryView: View {
    
    let screenSize = UIScreen.main.bounds.size
    let firstCategoryList: [StoryMainCategory] = StoryMainCategory.allCases
    @Binding var selectedFirstCategory: StoryMainCategory?
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(height: 0)
            ForEach(0..<self.firstCategoryList.count) { index in
                Button {
                    self.selectedFirstCategory = self.firstCategoryList[index]
                } label: {
                    Text(self.firstCategoryList[index].title)
                        .font(.system(size: 16, weight: .regular, design: .default))
                        .foregroundColor(.black)
                        .frame(width: self.screenSize.width * 0.85 - 15, alignment: .leading)
                        .padding(.leading, 15)
                }
                .padding(.bottom, 5)
                .padding(.top, 5)
                Rectangle()
                    .fill(.gray.opacity(0.6))
                    .frame(width: self.screenSize.width * 0.85, height: 1)
            }
            .frame(width: self.screenSize.width)
            Spacer()
        }
    }
}

struct SelectSecondCategoryView: View, StoryCategoryDelegate {
    let secondCategory: [StoryCategory]
    var selectedSecondCategory: Dictionary<String,Bool> = [:]
    var categoryDelegate: StoryCategoryDelegate?
    
    init(secondCategory: [StoryCategory]) {
        self.secondCategory = secondCategory
        
        // 전부 true인 딕셔너리 생성
        let userDefaultsDictionary: Dictionary<String,Bool> = Dictionary(StoryCategory.allCases.map { raw in
            (raw.rawString, true)
        }, uniquingKeysWith: {(first, _) in first})
        
        // 첫 실행일 경우 UserDefaults 값이 nil일 거니까, 위에서 만든 딕셔너리 저장
        self.selectedSecondCategory = UserDefaults.standard.dictionary(forKey: "StoryCategory") as? Dictionary<String,Bool> ?? userDefaultsDictionary
        print(self.selectedSecondCategory)
        self.categoryDelegate = self
        print("SelectSecondCategoryView init")
    }
    
    mutating func toggleCategory(category: StoryCategory) {
        // 선택된 카테고리 토글
//        self.selectedSecondCategory[category.rawString]?.toggle()
        self.selectedSecondCategory = UserDefaults.standard.dictionary(forKey: "StoryCategory") as! Dictionary<String,Bool>
        self.selectedSecondCategory[category.rawString]?.toggle()
        UserDefaults.standard.set(self.selectedSecondCategory, forKey: "StoryCategory")
        // UserDefaults에 저장
//        print("\nBefore UserDefaults")
//        print((UserDefaults.standard.dictionary(forKey: "StoryCategory") as! Dictionary<String,Bool>).sorted(by: { $0.key > $1.key }))
//        print(self.selectedSecondCategory.sorted(by: { $0.key > $1.key }))
//        UserDefaults.standard.set(self.selectedSecondCategory, forKey: "StoryCategory")
        // 지역 변수에도 저장
//        self.selectedSecondCategory = UserDefaults.standard.dictionary(forKey: "StoryCategory") as! Dictionary<String,Bool>
//        print("\nAfter UserDefaults")
        print((UserDefaults.standard.dictionary(forKey: "StoryCategory") as! Dictionary<String,Bool>).sorted(by: { $0.key > $1.key }))
        print(self.selectedSecondCategory.sorted(by: { $0.key > $1.key }))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ForEach(0...3, id: \.self) { i in
                    if i < self.secondCategory.count {
                        CategoryButton(category: self.secondCategory[i],
                                       categoryDelegate: self.categoryDelegate,
                                       isSelected: self.selectedSecondCategory[self.secondCategory[i].rawString] ?? true)
                    }
                }
                Spacer()
            }
            HStack {
                ForEach(4...7, id: \.self) { i in
                    if i < self.secondCategory.count {
                        CategoryButton(category: self.secondCategory[i],
                                       categoryDelegate: self.categoryDelegate,
                                       isSelected: self.selectedSecondCategory[self.secondCategory[i].rawString] ?? true)
                    }
                }
                Spacer()
            }
            HStack{
                ForEach(8...11, id: \.self) { i in
                    if i < self.secondCategory.count {
                        CategoryButton(category: self.secondCategory[i],
                                       categoryDelegate: self.categoryDelegate,
                                       isSelected: self.selectedSecondCategory[self.secondCategory[i].rawString] ?? true)
                    }
                }
                Spacer()
            }
        }
    }
}

struct CategoryButton: View {
    let category: StoryCategory
    @State var categoryDelegate: StoryCategoryDelegate?
    @State var isSelected: Bool
    
    var body: some View {
        Button {
            self.categoryDelegate?.toggleCategory(category: self.category)
            self.isSelected.toggle()
        } label: {
            Text(self.category.text)
                .font(.system(size: 14, weight: .regular, design: .default))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .foregroundColor(.black)
                .padding([.leading, .trailing], 15)
                .padding([.top, .bottom], 7)
                .background {
                    Capsule(style: .continuous)
                        .fill(self.isSelected ? Color.blue.opacity(0.6) : Color(.sRGB, white: 0.8, opacity: 1))
                        .overlay(
                            Capsule(style: .continuous)
                                .stroke(self.isSelected ? Color.blue.opacity(0.6) : .gray, lineWidth: 1)
                        )
                }
        }
    }
}

protocol StoryCategoryDelegate {
    mutating func toggleCategory(category: StoryCategory) -> ()
}

struct SelectCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCategoryView()
    }
}
