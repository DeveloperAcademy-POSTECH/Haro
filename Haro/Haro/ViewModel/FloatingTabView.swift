//
//  FloatingTabView.swift
//  Haro
//
//  Created by Moon Jongseek on 2022/04/06.
//

import SwiftUI

struct FloatingTabView: View {
    let cornerRadius: CGFloat = 17
    
    @Binding var currentPageIndex: Int
    
    func floatingTabButton(imageName: String, title: String, pageIndex: Int) -> some View{
        return Button {
            withAnimation {
                self.currentPageIndex = pageIndex
                print("Change Scroll Proxy")
            }
        } label: {
            let isSelected = (self.currentPageIndex == pageIndex)
            FloatingTabButtonView(imageName: imageName, title: title, isSelected: isSelected)
        }
        
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: self.cornerRadius, style: .circular)
                    .fill(.white)
                    .frame(height: 80)
                    .shadow(color: .gray, radius: 1, x: 0, y: 0.5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 17)
                            .stroke(.gray,lineWidth: 1)
                    )
                HStack(alignment: .center) {
                    self.floatingTabButton(imageName: "map", title: "지도", pageIndex: 0)
                    Spacer()
                    self.floatingTabButton(imageName: "person", title: "커뮤니티", pageIndex: 1)
                    Spacer()
                    self.floatingTabButton(imageName: "person", title: "마이페이지", pageIndex: 2)
                }
                .padding(.horizontal, 45)
            }
        }
        .padding([.leading, .trailing], 12)
    }
}

struct FloatingTabButtonView: View {
    let imageName: String
    let title: String
    let isSelected: Bool
    
    let deselectedColor: Color = Color.gray.opacity(0.8)
    
    var body: some View {
        VStack {
            Image(systemName: self.imageName)
                .imageScale(.large)
                .blendMode(.plusDarker)
                .foregroundColor(self.isSelected ? Color.black : self.deselectedColor)
            Text(self.title)
                .lineLimit(1)
                .font(.system(size: 12, weight: self.isSelected ? .bold : .regular))
                .foregroundColor(self.isSelected ? Color.black : self.deselectedColor)
                .frame(minHeight: 15)
        }
        .frame(width: 75, height: 75)
    }
}

//struct FloatingTabView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        FloatingTabView()
//    }
//}
