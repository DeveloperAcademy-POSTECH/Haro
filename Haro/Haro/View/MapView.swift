//
//  MapView.swift
//  Haro
//
//  Created by Shin Jae Ung on 2022/04/06.
//

import SwiftUI
import MapKit
import CoreLocationUI

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
        ZStack {
            Map(coordinateRegion: self.$coordinateRegion, annotationItems: [self.place] ) { place in
                MapPin(coordinate: self.place.location, tint: Color.purple)
            }
            .ignoresSafeArea()
            CreateStoryButton()
            MapButtonView()
        }
    }
}



struct CreateStoryButton: View {
    var body: some View {
        VStack {
            Spacer()
            Button {
                print("아무일도 일어나지 않습니다.")
            } label: {
                ZStack {
                    Capsule()
                        .fill(Color.init(red: 1, green: 144/255, blue: 0))
                    Text("지금 어떤 일이 일어나고 있나요?")
                        .lineLimit(1)
                        .font(.system(size: 15))
                        .minimumScaleFactor(0.005)
                        .foregroundColor(.white)
                        .padding([.leading, .trailing], 30)
                }
            }
            .frame(height: 50)
            .padding([.leading, .trailing], 90)
            
            Spacer()
                .frame(height: 130)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
