//
//  MainView.swift
//  Haro
//
//  Created by Moon Jongseek on 2022/04/06.
//

import SwiftUI

struct MainView: View {
    @State var currentPageIndex: Int = 0
    var body: some View {
        ZStack {
            PageControlView(currentPageIndex: self.currentPageIndex)
                .ignoresSafeArea()
            FloatingTabView(currentPageIndex: self.$currentPageIndex)
        }
    }
}

struct PageControlView: View {
    var currentPageIndex: Int
    var body: some View {
        GeometryReader { geometry in
            ScrollViewReader { scrollProxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        MapView()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .id(0)
                        CommunityView()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .id(1)
                        MyPageView()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .id(2)
                    }
                    .onChange(of: self.currentPageIndex) { target in
                        withAnimation{
                            scrollProxy.scrollTo(target)
                        }
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
