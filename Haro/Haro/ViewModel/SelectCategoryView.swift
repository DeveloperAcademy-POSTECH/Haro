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
    @State var selectedFirstCategory: String = ""
    @State var selectedSecondCategory: String = ""
    @State var navigationLinkIsActive: Bool = false
    
    let firstCategory = ["추천장소", "가게소식", "행사축제", "사건사고"]
    let screenSize = UIScreen.main.bounds.size
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    func navigationTitleView(selectedFirstCategory: String) -> some View {
        if selectedFirstCategory == "" {
            return AnyView(
                Text("받고싶은 소식 선택")
                    .font(.system(size: 18, weight: .bold, design: .default))
                    .padding([.top])
                    .frame(width: self.screenSize.width * 0.85, alignment: .leading)
            )
        } else {
            return AnyView(
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text(selectedFirstCategory)
                            .font(.system(size: 18, weight: .bold, design: .default))
                        Spacer()
                    }
                }
                    .foregroundColor(.black)
                    .padding([.top])
                    .frame(width: self.screenSize.width * 0.85, alignment: .leading)
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
                NavigationView {
                    VStack {
                        Rectangle()
                            .frame(height: 0)
                        ForEach(0..<self.firstCategory.count) { index in
                            NavigationLink(isActive: self.$navigationLinkIsActive) {
                                SelectSecondCategoryView(selectedFirstCategory: self.selectedFirstCategory)
                                    .onAppear {
                                        self.selectedFirstCategory = self.firstCategory[index]
                                    }
                            } label: {
                                Text(self.firstCategory[index])
                                    .font(.system(size: 16, weight: .regular, design: .default))
                                    .foregroundColor(.black)
                                    .frame(width: self.screenSize.width * 0.85 - 15, alignment: .leading)
                                    .padding(.leading, 15)
                            }
                            .onAppear {
                                self.selectedFirstCategory = ""
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
                    .navigationBarHidden(true)
//                    .toolbar {
//                        ToolbarItem(placement: .principal) {
//                            Text("받고싶은 소식 선택").font(.headline)
//                                .font(.system(size: 18, weight: .bold, design: .default))
//                                .padding([.top])
//                                .frame(width: self.screenSize.width * 0.85, alignment: .leading)
//                        }
//                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous) )
                Spacer()
                
            }
        }
        .frame(height: self.screenSize.height * 0.45)
    }
}

struct SelectSecondCategoryView: View {
    var selectedFirstCategory: String
    let secondCategory = ["카페", "문화생활", "마트", "공공시설", "옷가게", "식당", "산책로", "공원", "기타"]
    
    var body: some View {
        VStack {
            ForEach(0..<self.secondCategory.count) { index in
                if self.selectedFirstCategory == "추천장소" {
                    CategoryButton(title: self.secondCategory[index])
                }
            }
        }
        //        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        //        .toolbar {
        //            ToolbarItem(placement: .principal) {
        //                Text(self.selectedFirstCategory)
        //                    .font(.system(size: 18, weight: .bold, design: .default))
        //                HStack {
        //                    Text(self.selectedFirstCategory)
        //                        .font(.system(size: 18, weight: .bold, design: .default))
        //                    Image(systemName: "chevron.backward")
        //
        //                    Spacer()
        //                }
        //            }
        //        }
        
        
        //            .navigationBarHidden(true)
        //            .onDisappear{
        //                withAnimation {
        //                    self.selectedSecondCategory = ""
        //                }
        //            }
        //            .navigationBarHidden(false)
    }
}

struct CategoryButton: View {
    let title: String
    
    var body: some View {
        Button {
            
        } label: {
            ZStack {
                
                Text(self.title)
                    .font(.system(size: 14, weight: .regular, design: .default))
                    .foregroundColor(.black)
                    .padding([.leading, .trailing], 15)
                    .padding([.top, .bottom], 7)
                    .background {
                        Capsule(style: .continuous)
                            .fill(Color(.sRGB, white: 0.8, opacity: 1))
                            .overlay(
                                Capsule(style: .continuous)
                                    .stroke(.gray, lineWidth: 1)
                            )
                    }
                
            }
        }
    }
}
//                                    Button(self.firstCategory[index]){
//
//                                                            }
//                                                            .font(.system(size: 16, weight: .regular, design: .default))
//
//                                                            .foregroundColor(.black)
//                                                            .frame(width: self.screenSize.width * 0.85 - 15, alignment: .leading)
//                                                            .padding([.top, .bottom], 5)
//                                                            .padding(.leading, 15)

struct SelectCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        //        SelecteSecondCategoryView(selectedFirstCategory: "asdf")
        SelectCategoryView()
    }
}
