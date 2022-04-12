//
//  MainView.swift
//  Haro
//
//  Created by Moon Jongseek on 2022/04/06.
//

import SwiftUI

struct MainView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var storyOn: Bool = false
    @State private var showingCategoryView: Bool = false
    
    
    var body: some View {
        ZStack {
            TabView {
                MapView(storyOn: self.$storyOn,
                        showingCategoryView: self.$showingCategoryView)
                .edgesIgnoringSafeArea(.top)
                .tabItem {
                    TabItemView(imageName: "map", title: "지도")
                }
                
                CommunityView()
                    .tabItem {
                        TabItemView(imageName: "person", title: "커뮤니티")
                            .padding(0)
                    }
                
                MyPageView()
                    .tabItem {
                        TabItemView(imageName: "person", title: "마이페이지")
                    }
            }
            .accentColor(.black)
            
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
}

struct TabItemView: View {
    var imageName: String
    var title: String
    
    var body: some View {
        VStack {
            Image(systemName: self.imageName)
            Text(self.title)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
  


