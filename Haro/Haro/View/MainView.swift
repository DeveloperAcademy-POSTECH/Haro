//
//  MainView.swift
//  Haro
//
//  Created by Moon Jongseek on 2022/04/06.
//

import SwiftUI

struct MainView: View {
    @State var storyOn: Bool = false
    @State var selection: Int = 0
    @State private var showingCategoryView: Bool = false
    
    var body: some View {
        ZStack {
            TabView(selection: self.$selection) {
                MapView(storyOn: self.$storyOn,
                        showingCategoryView: self.$showingCategoryView)
                .tabItem {
                    TabItemView(imageName: "map", title: "지도")
                }
                
                CommunityView()
                    .tabItem {
                        TabItemView(imageName: "person", title: "커뮤니티")
                    }
                
                MyPageView()
                    .tabItem {
                        TabItemView(imageName: "person", title: "마이페이지")
                    }
                
            }
            if storyOn {
                StoryView(storyOn: self.$storyOn)
                    .transition(.move(edge: .bottom))
            }
            
            if self.showingCategoryView {
                ZStack {
                    VStack{
                        Spacer()
                        SelectCategoryView(showingCategoryView: self.$showingCategoryView)
                    }
                    .ignoresSafeArea()
                    .transition(.move(edge: .bottom))
                    .animation(.linear(duration: 0.2))
                }
            }
        }
        
    }
    //    @State private var currentPageIndex: Int = 0
    //    @State var storyOn: Bool = false
    //    @State private var showingCategoryView: Bool = false
    //
    //    let screenSize = UIScreen.main.bounds.size
    //
    //    var body: some View {
    //        ZStack {
    //            PageControlView(currentPageIndex: self.currentPageIndex,
    //                            showingCategoryView: self.$showingCategoryView,
    //                            storyOn: self.$storyOn)
    //            .onTapGesture {
    //                self.showingCategoryView = false
    //            }
    //
    //            FloatingTabView(currentPageIndex: self.$currentPageIndex)
    //            if storyOn {
    //                StoryView(storyOn: self.$storyOn)
    //                    .transition(.move(edge: .bottom))
    //            }
    //
    //            if self.showingCategoryView {
    //                ZStack {
    //                    VStack{
    //                        Spacer()
    //                        SelectCategoryView(showingCategoryView: self.$showingCategoryView)
    //                    }
    //                    .ignoresSafeArea()
    //                    .transition(.move(edge: .bottom))
    //                    .animation(.linear(duration: 0.2))
    //                }
    //            }
    //        }
    //    }
}

struct TabItemView: View {
    var imageName: String
    var title: String
    
    var body: some View {
        VStack {
            Image(systemName: self.imageName)
            //                .imageScale(.large)
            Text(self.title)
        }
    }
}

struct PageControlView: View {
    var currentPageIndex: Int
    
    @State var scrollAxis: Axis.Set = .horizontal
    @Binding var showingCategoryView: Bool
    @Binding var storyOn: Bool
    
    var body: some View {
        if self.currentPageIndex == 0 {
            MapView(storyOn: self.$storyOn,
                    showingCategoryView: self.$showingCategoryView)
            //            .transition(.move(edge: .leading))
        } else if self.currentPageIndex == 1 {
            CommunityView()
        } else {
            MyPageView()
            //                .transition(.move(edge: .trailing))
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
