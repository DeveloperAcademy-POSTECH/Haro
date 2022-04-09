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
    @Binding var stroyOn: Bool
    var body: some View {
//        NavigationLink {
//            StoryView()
//                .navigationBarHidden(true)
//                .navigationBarBackButtonHidden(true)
//        } label: {
//            Image(systemName: "moon.stars.fill")
//                .font(.title)
//                .foregroundColor(.purple)
//        }
//        .navigationBarHidden(true)
//        .navigationBarBackButtonHidden(true)
        
        Button{
            withAnimation (.easeInOut(duration: 0.5)) {
                stroyOn.toggle()
            }

        } label: {
            Image(systemName: "moon.stars.fill")
                .font(.title)
                .foregroundColor(.purple)
        }
    }
}


struct MapView: View {
    @Binding var storyOn: Bool
    let place: IdentifiablePlace = IdentifiablePlace(lat: 36.014279, long: 129.325785)
   
    @Binding var showingCategoryView: Bool
    @StateObject var viewModel = MapViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true,
                annotationItems: [place]) {
                place in MapAnnotation(coordinate: place.location) {
                    PlaceAnnotationView(stroyOn: self.$storyOn)
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
            MapButtonView(showingCategoryView: self.$showingCategoryView)
        }
        .ignoresSafeArea()
    }
}

struct CreateStoryButton: View {
    @State private var showStoryWriteView = false
    
    var body: some View {
        VStack {
            Spacer()
            Button {
                self.showStoryWriteView = true
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
        .sheet(isPresented: self.$showStoryWriteView) {
            StoryWriteView(showModal: $showStoryWriteView)
        }
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}

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

