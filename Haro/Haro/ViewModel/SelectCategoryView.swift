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
    let screenSize = UIScreen.main.bounds.size
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.white)
                .shadow(color: .gray.opacity(0.5), radius: 2, x: 0, y: -2)
            VStack(alignment: .leading) {
                Text("받고싶은 소식 선택")
                    .font(.system(size: 18, weight: .bold, design: .default))
                    .padding([.top])
                ForEach(0..<self.firstCategory.count) { index in
                    Button(self.firstCategory[index]){
                        
                    }
                    .font(.system(size: 16, weight: .regular, design: .default))
                    
                    .foregroundColor(.black)
                    .frame(width: self.screenSize.width * 0.85 - 15, alignment: .leading)
                    .padding([.top, .bottom], 5)
                    .padding(.leading, 15)
                    Rectangle()
                        .fill(.gray.opacity(0.6))
                        .frame(width: self.screenSize.width * 0.85, height: 1)
                }
                Spacer()
            }
        }
        .frame(height: self.screenSize.height * 0.45)
    }
}

//location.fill
//location

struct SelectCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCategoryView()
    }
}
