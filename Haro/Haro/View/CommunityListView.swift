//
//  CommunityListView.swift
//  Haro
//
//  Created by Shin Jae Ung on 2022/04/06.
//

import SwiftUI

struct CommunityListView: View {
    let title: String
    
    var body: some View {
        VStack {
            List(0 ..< 5) { item in
                CommunityListCell()
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
            }
            .listRowBackground(Color.red)
            .listStyle(.plain)
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(title)
        .toolbar {
            Image
                .init(systemName: "magnifyingglass")
                .scaledToFit()
                .frame(width: 25.5, height: 25.5)
        }
    }
}

struct CommunityListCell: View {
    var body: some View {
        ZStack {
            VStack {
                HStack(alignment: .top) {
                    Image(systemName: "xmark")
                        .frame(width: 30, height: 30)
                    Text("중앙공원 고양이를 산책로에서 만났어요! 역시 터줏대감 중앙냥이.. 귀여우니까 같이 봐줘요!!")
                        .fixedSize(horizontal: false, vertical: true)
                }
                HStack {
                    Spacer()
                    Image(systemName: "xmark")
                    Text("23")
                    Image(systemName: "xmark")
                    Text("23")
                }
            }
            .padding(10)
            .background(.white)
            .cornerRadius(20)
        }
    }
}

struct CommunityListView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityListView(title: "귀여운 동물 출몰")
    }
}

struct ListRowBackground: View {
    var body: some View {
        ZStack {
            Color.red
            Color.red
                .cornerRadius(8)
                .padding(.vertical, 4)
        }
    }
}
