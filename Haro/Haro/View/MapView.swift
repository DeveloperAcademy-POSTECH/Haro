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
        Button{
            print("StoryView")} label: {
                Image(systemName: "moon.stars.fill")
                    .font(.title)
                    .foregroundColor(.purple)
            }
    }
}


struct MapView: View {
    let place: IdentifiablePlace = IdentifiablePlace(lat: 36.014279, long: 129.325785)
   
    @StateObject var viewModel = MapViewModel()
    @StateObject var locationManager = MapViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true,
                annotationItems: [place])
            { place in
                MapAnnotation(coordinate: place.location) {
                    PlaceAnnotationView()
                }
            }
            
            HStack {
                Spacer()
                
                VStack {
                    Button {
                        Void()
                    } label: {
                        Rectangle()
                            .frame(width: 60, height: 60)
                            .tint(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                    Button {
                        Void()
                    } label: {
                        Rectangle()
                            .frame(width: 60, height: 60)
                            .tint(.white)
                            .cornerRadius(8)
                    }
                    LocationButton(.currentLocation) {
                        viewModel.requestWhenInUseAuthorization()
                    }
                    .foregroundColor(.black)
                    .tint(.white)
                    .cornerRadius(8)
                    .font(.system(size: 26))
                    .labelStyle(.iconOnly)
                    .padding()
                }
                .padding()
            }
            CreateStoryButton()
        }
        .ignoresSafeArea()
    }
}

extension Notification.Name {
  static let goToCurrentLocation = Notification.Name("goToCurrentLocation")
}

private func goToUserLocation() {
    NotificationCenter.default.post(name: .goToCurrentLocation, object: nil)
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
    private let locationManager = CLLocationManager()
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 36.014279, longitude: 129.325785),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    var locationPermission : Bool {
        switch self.locationManager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse : return true
            default : return false
        }
    }
    
    override init() {
        super.init()
        
        locationManager.delegate = self
    }
    
    func requestWhenInUseAuthorization() {
        locationManager.requestLocation()
        locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first
        else { return }
        
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(
                center: latestLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
