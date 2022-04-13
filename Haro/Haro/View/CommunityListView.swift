//
//  CommunityListView.swift
//  Haro
//
//  Created by Shin Jae Ung on 2022/04/06.
//

import SwiftUI

struct CommunityListView: View {
    let title: String
    @ObservedObject var viewModel: CommunityListViewModel
    
    init(of category: CommunityCategory) {
        self.title = category.text
        self.viewModel = CommunityListViewModel(category)
    }
    
    var body: some View {
        VStack {
            List(0..<max((viewModel.entity?.count ?? 0), viewModel.meetingEntity?.count ?? 0), id: \.self) { item in
                ZStack{
                    if CommunityCategory.inside(of: .meeting).contains(where: { $0 == viewModel.category }) {
                        NavigationLink (destination: CommunityMeetingPostView(entity: viewModel.meetingEntity![item])){
                            EmptyView()
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: 0, height: 0)
                        
                        CommunityMeetingListCell(category: viewModel.category.rawValue, title: viewModel.title(of: item), descript: viewModel.descript(of: item), attendee: viewModel.attendee(of: item))
                    } else {
                        NavigationLink (destination: CommunityPostView(entity: viewModel.entity![item])){
                            EmptyView()
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: 0, height: 0)
                        CommunityListCell(category: viewModel.category.rawValue, text: viewModel.text(of: item), like: viewModel.like(of: item), comment: viewModel.comment(of: item))
                    }
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
            }
            .listRowBackground(Color.red)
            .listStyle(.plain)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(title)
        .toolbar {
            Image
                .init(systemName: "magnifyingglass")
                .scaledToFit()
                .frame(width: 25.5, height: 25.5)
                .padding(.trailing, 5)
        }
        .onAppear {
            viewModel.configure()
        }
    }
}

struct CommunityMeetingListCell: View {
    let category: String
    let title: String
    let descript: String
    let attendee: String
    
    var body: some View {
        ZStack {
            VStack {
                HStack(alignment: .top) {
                    Image(category)
                        .frame(width: 30, height: 30)
                    VStack{
                        HStack {
                            Text(title)
                                .fontWeight(.bold)
                                .font(.body)
                                .minimumScaleFactor(1)
                                .lineLimit(1)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                        }
                        .padding(.vertical, 5)
                        HStack {
                            Text(descript)
                                .font(.caption)
                                .minimumScaleFactor(1)
                                .lineLimit(3)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                        }
                    }
                }
                HStack {
                    Spacer()
                    Text("🌞" + attendee)
                }
                .padding(.bottom, 5)
            }
            .padding(10)
            .background(.white)
            .cornerRadius(20)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 10)
        .cornerRadius(20)
        .shadow(color: Color(red: 220/255, green: 222/255, blue: 224/255), radius: 10, x: 0, y: 4)
    }
}

struct CommunityListCell: View {
    let category: String
    let text: String
    let like: String
    let comment: String
    
    var body: some View {
        ZStack {
            VStack {
                HStack(alignment: .top) {
                    Image(category)
                        .frame(width: 30, height: 30)
                    HStack {
                        Text(text)
                            .minimumScaleFactor(1)
                            .lineLimit(3)
                            .fixedSize(horizontal: false, vertical: true)
                        Spacer()
                    }
                }
                HStack {
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    Text(like)
                    Image(systemName: "message.fill")
                        .foregroundColor(Color(red: 227/255, green: 230/255, blue: 233/255))
                    Text(comment)
                }
                .padding(.bottom, 5)
            }
            .padding(10)
            .background(.white)
            .cornerRadius(20)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 10)
        .cornerRadius(20)
        .shadow(color: Color(red: 220/255, green: 222/255, blue: 224/255), radius: 10, x: 0, y: 4)

    }
}

struct CommunityListView_Previews: PreviewProvider {
    static var previews: some View {
        return Rectangle()
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
