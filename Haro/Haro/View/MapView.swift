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
    let id: UUID = UUID()
    let location: CLLocationCoordinate2D
    let storyEntity: StoryEntity
    init(storyEntity: StoryEntity) {
        self.storyEntity = storyEntity
        self.location = CLLocationCoordinate2D(
            latitude: storyEntity.latitude,
            longitude: storyEntity.longitude)
    }
}

struct PlaceAnnotationView: View {
    @Binding var stroyOn: Bool
    var storyEntity: StoryEntity
    let imageSize: CGFloat = 45
    
    func categoryImage() -> Image {
        let category = self.storyEntity.category
        var imageName = ""
        StoryMainCategory.allCases.map { mainCategory in
            let categoryArray = StoryCategory.inside(of: mainCategory).map {
                $0.rawString
            }
            if categoryArray.contains(category) {
                imageName = mainCategory.rawValue
            }
        }
        return Image(imageName)
    }
    
    var body: some View {
        Button{
            withAnimation (.easeInOut(duration: 0.5)) {
                stroyOn.toggle()
            }
            
        } label: {
            self.categoryImage()
                .resizable()
                .scaledToFit()
                .frame(width: self.imageSize, height: self.imageSize)
            
        }
    }
}


struct MapView: View {
    @Binding var storyOn: Bool
    @State var mapPins: [IdentifiablePlace] = []
    
    @Binding var showingCategoryView: Bool
    @StateObject var viewModel = MapViewModel()
    
    func readJSON() -> Data? {
        do {
            if let bundlePath = Bundle.main.url(forResource: "StoryRawData", withExtension: "json") {
                let jsonData = try Data(contentsOf: bundlePath)
                return jsonData
            } else {
                return nil
            }
        } catch {
            print("JSON Read Error")
        }
        
        return nil
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true,
                annotationItems: mapPins) { pin in
                MapAnnotation(coordinate: pin.location) {
                    PlaceAnnotationView(stroyOn: self.$storyOn, storyEntity: pin.storyEntity)
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
            GeometryReader { geometry in
                MapButtonView(showingCategoryView: self.$showingCategoryView)
                    .padding(.top, geometry.safeAreaInsets.bottom - 35)
            }
            
            
        }
        .onAppear {
            if let jsonData = self.readJSON() {
                do {
                    let mapPinsData = try JSONDecoder().decode([StoryEntity].self, from: jsonData)
                    self.mapPins = mapPinsData.map { (storyEntity) -> IdentifiablePlace in
                        return IdentifiablePlace(storyEntity: storyEntity)
                    }
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
            }
        }
    }
}

struct CreateStoryButton: View {
    @State private var showStoryWriteView = false
    
    func readJSON() -> Data? {
        do {
            if let bundlePath = Bundle.main.url(forResource: "StoryRawData", withExtension: "json") {
                print(bundlePath)
                let jsonData = try Data(contentsOf: bundlePath)
                return jsonData
            } else {
                return nil
            }
        } catch {
            print("JSON Read Error")
        }
        
        return nil
    }
    
    var body: some View {
        VStack {
            Spacer()
            Button {
                //                var mapPinsData: [StoryEntity] = []
                //                if let jsonData = self.readJSON() {
                //                    do {
                //                        mapPinsData = try JSONDecoder().decode([StoryEntity].self, from: jsonData)
                //                    } catch {
                //                        print("error: ", error)
                //                    }
                //                }
                //                let newPinData = StoryEntity(userID: "TestUser", latitude: 36.008179, longitude: 129.331589, category: "restaurant", imageName: "restaurant0.jpg")
                //                mapPinsData.append(newPinData)
                //                print(mapPinsData)
                
                //                    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
                //                if let documentDirectoryUrl = FileManager.default.urls(for: .applicationDirectory, in: .userDomainMask).first {
                //                        let fileUrl = documentDirectoryUrl.appendingPathComponent("rawData.json")
                //                        print(fileUrl)
                //                        do {
                //                            let newData = try JSONEncoder().encode(mapPinsData)
                //                            let jsonString = String(decoding: newData, as: UTF8.self)
                //                        try jsonString.write(to: fileUrl, atomically: true, encoding: .utf8)
                //                        print(jsonString)
                //                        } catch {
                //                            print(error)
                //                        }
                //                    }
                self.showStoryWriteView = true
            } label: {
                ZStack {
                    Capsule()
                        .fill(Color.init(red: 1, green: 144/255, blue: 0))
                    Text("지금 어떤 일이 일어나고 있나요?")
                        .lineLimit(1)
                        .font(.system(size: 16))
                        .minimumScaleFactor(0.005)
                        .foregroundColor(.white)
                        .padding([.leading, .trailing], 30)
                }
            }
            .frame(height: 50)
            .padding([.leading, .trailing], 90)
            .padding(.bottom, 17)
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

