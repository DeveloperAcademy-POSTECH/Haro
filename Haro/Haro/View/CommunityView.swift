//
//  CommunityView.swift
//  Haro
//
//  Created by Shin Jae Ung on 2022/04/06.
//

import SwiftUI

struct CommunityView: View {
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
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
                    
                    Image("community")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                        .padding([.leading, .trailing, .bottom])
                    
                    CategoryView().padding(.horizontal)
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        .accentColor(.black)
    }
}

struct CategoryView: View {
    @ObservedObject var viewModel = CategoryViewModel()
    
    var body: some View {
        VStack {
            HStack {
                ForEach(viewModel.mainCategories, id: \.self) { category in
                    Button {
                        switch category {
                        case .meeting:
                            viewModel.selectedMainCategory = .meeting
                        case .place: viewModel.selectedMainCategory = .place
                        case .news: viewModel.selectedMainCategory = .news
                        case .event: viewModel.selectedMainCategory = .event
                        case .accident: viewModel.selectedMainCategory = .accident
                        }
                    } label: {
                        if viewModel.selectedMainCategory == category {
                            Text(category.title)
                                .foregroundColor(.black)
                        } else {
                            Text(category.title)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal, 5)
                    .padding(.vertical, 5)
                    if category != viewModel.mainCategories.last! {
                        Spacer()
                    }
                }
            }
            
            ForEach(0..<viewModel.categories.count, id: \.self) { number in
                NavigationLink {
                    CommunityListView(of: viewModel.categories[number])
                } label: {
                    HStack {
                        Text(viewModel.categories[number].text)
                            .padding()
                            .foregroundColor(number == 0 ? .black : .white)
                        Spacer()
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(viewModel.colors[number])
            }
        }
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
    }
}

