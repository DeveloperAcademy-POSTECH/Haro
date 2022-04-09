//
//  CommunityView.swift
//  Haro
//
//  Created by Shin Jae Ung on 2022/04/06.
//

import SwiftUI

struct CommunityView: View {
    var body: some View {
        VStack {
            HStack {
                Text("커뮤니티")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Image
                    .init(systemName: "magnifyingglass")
                    .scaledToFit()
                    .frame(width: 25.5, height: 25.5)
            }
            .padding(.all)
            
            Rectangle()
                .foregroundColor(.gray)
                .cornerRadius(20)
                .padding(.horizontal)
                .aspectRatio(350/200, contentMode: .fit)
            
            CategoryView().padding(.horizontal)
            
            Spacer()
        }
    }
}

struct CategoryView: View {
    @ObservedObject var viewModel = CategoryViewModel()
    
    var body: some View {
        VStack {
            HStack {
                ForEach(CategoryViewModel.MainCategory.allCases, id: \.self) { category in
                    Button {
                        self.viewModel.selectedCategory = category
                    } label: {
                        if viewModel.selectedCategory == category {
                            Text(category.title)
                                .foregroundColor(.black)
                        } else {
                            Text(category.title)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal, 5)
                    .padding(.vertical, 5)
                    if category != CategoryViewModel.MainCategory.allCases.last! {
                        Spacer()
                    }
                }
            }
            
            ForEach(viewModel.selectedCategory.contents, id: \.self) { content in
                Button {
                    Void()
                } label: {
                    HStack {
                        Text(content)
                            .padding()
                        Spacer()
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.yellow)
            }
        }
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
    }
}
