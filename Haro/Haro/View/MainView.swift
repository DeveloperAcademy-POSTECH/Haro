//
//  MainView.swift
//  Haro
//
//  Created by Moon Jongseek on 2022/04/06.
//

import SwiftUI

struct MainView: View {
    @State private var currentPageIndex: Int = 0
    @State private var showingCategoryView: Bool = false
    
    let screenSize = UIScreen.main.bounds.size
    
    var body: some View {
        ZStack {
            PageControlView(currentPageIndex: self.currentPageIndex,
                            showingCategoryView: self.$showingCategoryView)
            .ignoresSafeArea()
            FloatingTabView(currentPageIndex: self.$currentPageIndex)
            ZStack {
                if self.showingCategoryView {
                    VStack{
                        Spacer()
                        SelectCategoryView()
                    }
                    .ignoresSafeArea()
                    .transition(.move(edge: .bottom))
                    .animation(.linear(duration: 0.2))
                }
            }
        }
    }
}

struct PageControlView: View {
    var currentPageIndex: Int
    @State var scrollAxis: Axis.Set = .horizontal
    @Binding var showingCategoryView: Bool
    
    var body: some View {
        if self.currentPageIndex == 0 {
            MapView(showingCategoryView: self.$showingCategoryView)
        } else if self.currentPageIndex == 1 {
            CommunityView()
        } else {
            MyPageView()
        }
        
//        GeometryReader { geometry in
//            ScrollViewReader { scrollProxy in
//                ScrollView(self.scrollAxis, showsIndicators: false) {
//                    HStack {
//                        MapView(showingCategoryView: self.$showingCategoryView)
//                            .frame(width: geometry.size.width, height: geometry.size.height)
//                            .id(0)
//                        CommunityView()
//                            .frame(width: geometry.size.width, height: geometry.size.height)
//                            .id(1)
//                        MyPageView()
//                            .frame(width: geometry.size.width, height: geometry.size.height)
//                            .id(2)
//                    }
//                    .onChange(of: self.currentPageIndex) { target in
//                        withAnimation {
//                            scrollProxy.scrollTo(target)
//                        }
//                    }
//                }
//            }
//        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
