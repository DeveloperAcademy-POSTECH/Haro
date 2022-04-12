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
    @Binding var showingCategoryView: Bool
    
    let screenSize = UIScreen.main.bounds.size
    
    func navigationTitleView(selectedFirstCategory: StoryMainCategory?) -> some View {
        if selectedFirstCategory == nil {
            return AnyView(
                Text("스토리 카테고리")
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
                HStack(spacing: 10) {
                    self.navigationTitleView(selectedFirstCategory: self.selectedFirstCategory)
                    Spacer()
                    Button {
                        self.showingCategoryView.toggle()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                    }
                }
                .padding([.top], 35)
                .frame(width: self.screenSize.width * 0.85, alignment: .leading)
                
                
                if self.selectedFirstCategory == nil {
                    SelectFirstCategoryView(selectedFirstCategory: self.$selectedFirstCategory)
                        .frame(width: self.screenSize.width * 0.85)
                } else {
                    SelectSecondCategoryView(secondCategory: StoryCategory.inside(of: self.selectedFirstCategory ?? .place) )
                        .frame(width: self.screenSize.width * 0.85)
                }
                
                Spacer()
//                if selectedFirstCategory != nil {
//                    Button {
//                        self.showingCategoryView.toggle()
//                    } label: {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 20, style: .circular)
//                                .fill(Color(red: 234/255, green: 246/255, blue: 146/255, opacity: 1))
//                            Text("완료")
//                                .font(.system(size: 16, weight: .semibold, design: .default))
//                                .foregroundColor(.black)
//                        }
//
//                    }
//                    .frame(height: 50, alignment: .center)
//                    .padding([.leading, .trailing], 20)
//
//                }
                
                Rectangle()
                    .fill(.white)
                    .frame(height: 20)
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
        HStack {
            Spacer()
            ForEach(0..<self.firstCategoryList.count) { index in
                Button {
                    self.selectedFirstCategory = self.firstCategoryList[index]
                } label: {
                    VStack {
                        RoundedRectangle(cornerRadius: self.screenSize.width * 0.15 * 0.4, style: .circular)
                            .fill(Color(red: 246/255, green: 248/255, blue: 249/255))
                            .frame(width: self.screenSize.width * 0.15, height: self.screenSize.width * 0.15)
                            .overlay(
                                Image(StoryMainCategory.allCases[index].rawValue)
                                    .resizable()
                                    .frame(width: self.screenSize.width * 0.10, height: self.screenSize.width * 0.10)
                                    .scaledToFit()
                            )
                        Text(self.firstCategoryList[index].title)
                            .font(.system(size: 12, weight: .semibold, design: .default))
                            .foregroundColor(.black)
                            .frame(alignment: .center)
                    }
                }
                Spacer()
            }
        }
    }
}

struct SelectSecondCategoryView: View, StoryCategoryDelegate {
    let secondCategory: [StoryCategory]
    var selectedSecondCategory: Dictionary<String,Bool> = [:]
    var categoryDelegate: StoryCategoryDelegate?
    
    @AppStorage("StoryCategory", store: .standard) var selectedCategoryData: Data?
    
    init(secondCategory: [StoryCategory]) {
        self.secondCategory = secondCategory
        do {
            self.selectedSecondCategory = try JSONDecoder().decode([String:Bool].self, from: self.selectedCategoryData ?? Data())
        } catch  {
            print("Decoding Error")
        }
        self.categoryDelegate = self
    }
    
    mutating func toggleCategory(category: StoryCategory) {
        do {
            self.selectedSecondCategory = try JSONDecoder().decode([String:Bool].self, from: self.selectedCategoryData ?? Data())
            self.selectedSecondCategory[category.rawValue]?.toggle()
            let data = try JSONEncoder().encode(self.selectedSecondCategory)
            self.selectedCategoryData = data
        } catch {
            print("Codable Error")
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ForEach(0...3, id: \.self) { i in
                    if i < self.secondCategory.count {
                        CategoryButton(category: self.secondCategory[i],
                                       categoryDelegate: self.categoryDelegate,
                                       isSelected: self.selectedSecondCategory[self.secondCategory[i].rawValue] ?? true)
                    }
                }
                Spacer()
            }
            .frame(alignment: .center)
            HStack {
                ForEach(4...7, id: \.self) { i in
                    if i < self.secondCategory.count {
                        CategoryButton(category: self.secondCategory[i],
                                       categoryDelegate: self.categoryDelegate,
                                       isSelected: self.selectedSecondCategory[self.secondCategory[i].rawValue] ?? true)
                    }
                }
                Spacer()
            }
            .frame(alignment: .center)
            HStack{
                ForEach(8...11, id: \.self) { i in
                    if i < self.secondCategory.count {
                        CategoryButton(category: self.secondCategory[i],
                                       categoryDelegate: self.categoryDelegate,
                                       isSelected: self.selectedSecondCategory[self.secondCategory[i].rawValue] ?? true)
                    }
                }
                Spacer()
            }
            .frame(alignment: .center)
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
                        .fill(self.isSelected ? Color(red: 234/255, green: 246/255, blue: 146/255) : Color(red: 246/255, green: 248/255, blue: 249/255))
                        .overlay(
                            Capsule(style: .continuous)
                                .stroke(Color(red: 231/255,  green: 231/255, blue: 231/255), lineWidth: 1)
                        )
                }
        }
    }
}

protocol StoryCategoryDelegate {
    mutating func toggleCategory(category: StoryCategory) -> ()
}

//struct SelectCategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectCategoryView()
//    }
//}
