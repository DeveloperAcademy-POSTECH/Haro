//
//  MapView.swift
//  Haro
//
//  Created by Shin Jae Ung on 2022/04/06.
//

import SwiftUI
import MapKit

struct IdentifiablePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    init(id: UUID = UUID(), lat: Double, long: Double) {
        self.id = id
        self.location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
    }
}

struct MapView: View {
    let place: IdentifiablePlace = IdentifiablePlace(lat: 36.014279, long: 129.325785)
    @State var coordinateRegion: MKCoordinateRegion = MKCoordinateRegion (
        center: CLLocationCoordinate2D (
            latitude: 36.014279,
            longitude: 129.325785
        ),
        span: MKCoordinateSpan (
            latitudeDelta: 0.005,
            longitudeDelta: 0.005
        )
    )
    
    var body: some View {
        Map(coordinateRegion: self.$coordinateRegion, annotationItems: [self.place]) { place in
            MapPin(coordinate: self.place.location, tint: Color.purple)
        }
        .ignoresSafeArea()
    }
}

struct MainView: View {
    @State var currentPageIndex: Int = 2
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

struct FloatingTabView: View {
    let cornerRadius: CGFloat = 17
    
    @Binding var currentPageIndex: Int
    
    func floatingTabButton(imageName: String, title: String, pageIndex: Int) -> some View{
        return Button {
            withAnimation {
                self.currentPageIndex = pageIndex
                print("Change Scroll Proxy")
            }
        } label: {
            let isSelected = (self.currentPageIndex == pageIndex)
            FloatingTabButtonView(imageName: imageName, title: title, isSelected: isSelected)
        }
        
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: self.cornerRadius, style: .circular)
                    .fill(.white)
                    .frame(height: 80)
                    .shadow(color: .gray, radius: 1, x: 0, y: 0.5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 17)
                            .stroke(.gray,lineWidth: 1)
                    )
                HStack(alignment: .center) {
                    Spacer()
                    Spacer()
                    Spacer()
                    HStack {
                        self.floatingTabButton(imageName: "map", title: "지도", pageIndex: 0)
                        Spacer()
                        self.floatingTabButton(imageName: "person", title: "커뮤니티", pageIndex: 1)
                        Spacer()
                        self.floatingTabButton(imageName: "person", title: "마이페이지", pageIndex: 2)
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                }
            }
        }
        .padding([.leading, .trailing], 12)
    }
}

struct FloatingTabButtonView: View {
    let imageName: String
    let title: String
    let isSelected: Bool
    
    let deselectedColor: Color = Color.gray.opacity(0.8)
    
    var body: some View {
        VStack {
            Image(systemName: self.imageName)
                .imageScale(.large)
                .blendMode(.plusDarker)
                .foregroundColor(self.isSelected ? Color.black : self.deselectedColor)
            Text(self.title)
                .lineLimit(1)
                .font(.system(size: 12, weight: self.isSelected ? .bold : .regular))
                .foregroundColor(self.isSelected ? Color.black : self.deselectedColor)
                .frame(minHeight: 15)
        }
        .frame(width: 75, height: 75)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
