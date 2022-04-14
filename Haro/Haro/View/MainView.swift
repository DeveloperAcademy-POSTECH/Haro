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
    @StateObject private var arViewLocation: ARViewLocation = ARViewLocation()
    
    var body: some View {
        ZStack {
            TabView {
                MapView(storyOn: self.$storyOn,
                        showingCategoryView: self.$showingCategoryView,
                        arViewLocation: self.arViewLocation)
                .accentColor(.blue)
                .edgesIgnoringSafeArea(.top)
                .tabItem {
                    TabItemView(imageName: "map", title: "지도")
                        .environment(\.symbolVariants, .none)
                }
                
                CommunityView()
                    .tabItem {
                        TabItemView(imageName: "doc.plaintext", title: "커뮤니티")
                            .environment(\.symbolVariants, .none)
                    }
                
                MyPageView()
                    .tabItem {
                        TabItemView(imageName: "person", title: "마이페이지")
                            .environment(\.symbolVariants, .none)
                    }
            }
            .accentColor(.black)
            
            if self.storyOn {
                StoryView(storyOn: self.$storyOn)
                    .transition(.move(edge: .bottom))
            }
            
            if self.arViewLocation.showingARView {
                ARView(arViewLocation: self.arViewLocation)
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
  


