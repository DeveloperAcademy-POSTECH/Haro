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
    
    let firstCategory = ["추천장소", "가게소식", "행사축제", "사건사고"]
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(.white)
                    .shadow(color: .gray, radius: 2, x: 0, y: -1)
                NavigationView {
                    Form {
                        ForEach(0..<self.firstCategory.count) { index in
                            Button{
                                print("index")
                            } label: {
                                Text("\(self.firstCategory[index])")
                                    .foregroundColor(.black)
                            }
                        }
                        .navigationTitle("보고싶은 소식 선택")
                        .navigationBarTitleDisplayMode(.large)
                    }
                    .background(.white)
                }
                .padding(.top, 30)
                
            }
            LocationButton() {
                self.imageName = (self.imageName == "location") ? "location.fill" : "location"
                print("LocationButton")
            }
            .labelStyle(.iconOnly)
            .overlay {
                ZStack {
                    Rectangle()
                        .fill(.blue)
                        .cornerRadius(9)
                    Image(systemName: self.imageName)
                        .foregroundColor(.black)
                }
                .frame(width: 60, height: 60)

            }
        }
    }
    
    func changeColor() {
        
    }
}

//location.fill
//location

struct SelectCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCategoryView()
    }
}
