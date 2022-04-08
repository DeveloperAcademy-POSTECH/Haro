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
            Text("text")
        }
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

struct CommunityListView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityListView(title: "귀여운 동물 출몰")
    }
}
