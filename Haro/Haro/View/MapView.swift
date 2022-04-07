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

struct PlaceAnnotationView: View {
    var body: some View {
        ZStack{
            NavigationLink {
                StoryView()
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
            } label: {
                Image(systemName: "moon.stars.fill")
                    .font(.title)
                    .foregroundColor(.purple)
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        
        }
        
//        Button{
//            print("StoryView")
//
//        } label: {
//            Image(systemName: "moon.stars.fill")
//                .font(.title)
//                .foregroundColor(.purple)
//        }
    }
}


struct MapView: View {
    let place: IdentifiablePlace = IdentifiablePlace(lat: 36.014279, long: 129.325785)
   
    @StateObject var viewModel = MapViewModel()
    
    //    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.014279, longitude: 129.325785), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true,
                annotationItems: [place]) {
                place in MapAnnotation(coordinate: place.location) {
                    PlaceAnnotationView()
                }
            }
            LocationButton(.currentLocation) {
                viewModel.requestAllowOnceLocationPermission()
            }
            .foregroundColor(.white)
            .cornerRadius(8)
            .labelStyle(.iconOnly)
            .padding(.leading, 300.0)
            CreateStoryButton()
        }
        .ignoresSafeArea()
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

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 36.014279, longitude: 129.325785), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestAllowOnceLocationPermission() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:
                         [CLLocation]) {
        guard let latestLocation = locations.first else {
            return
        }
        
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(center: latestLocation.coordinate, span:
                                                MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

