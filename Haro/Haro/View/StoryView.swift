//
//  StoryView.swift
//  Haro
//
//  Created by Shin Jae Ung on 2022/04/06.
//

import SwiftUI
import MapKit

struct StoryView: View {
    @Binding var storyOn: Bool
    var storyEntity: StoryEntity? = {
        if let data = UserDefaults.standard.value(forKey:"SelectedStory") as? Data {
            let storyEntity = try? PropertyListDecoder().decode(StoryEntity.self, from: data)
            return storyEntity
        } else { return nil }
    }()
    @State var storyLocationTitle = ""
    @State var coordinateRegion: MKCoordinateRegion = MKCoordinateRegion ( center: CLLocationCoordinate2D ( latitude: 36.014279, longitude: 129.325785 ), span: MKCoordinateSpan ( latitudeDelta: 0.005, longitudeDelta: 0.005 ) )
    @State var onMap = false
    @State var isLike = false
    
    let screenHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(.black)
                .ignoresSafeArea()
            
            Image(self.storyEntity?.imageName ?? "")
                .resizable()
                .blur(radius: 20)
                .ignoresSafeArea()
            
            Image(self.storyEntity?.imageName ?? "")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
            
            VStack{
                HStack {
                    ZStack{
                        if let storyEntity = storyEntity {
                            Image(storyEntity.userPhoto)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .padding()
                                .clipShape(Circle())
                            
                            Image(StoryCategory(rawValue: storyEntity.category)!.main.rawValue)
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding([.leading, .top], 35)
                                .clipShape(Circle())
                        } else {
                            Circle()
                                .stroke()
                                .frame(width: 50, height: 50)
                                .padding()
                                .foregroundColor(.white)
                            
                            Circle()
                                .stroke()
                                .frame(width: 30, height: 30)
                                .padding([.leading, .top], 35)
                                .foregroundColor(.white)
                        }
                    }
                    VStack(alignment: .leading) {
                        Text(self.storyEntity?.userID ?? "")
                            .font(.body)
                            .foregroundColor(.white)
                        Text(StoryCategory(rawValue: storyEntity!.category)!.text)
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                    
                    Button {
                        withAnimation{
                            self.storyOn.toggle()
                            UserDefaults.standard.removeObject(forKey: "SelectedStory")
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .padding(.trailing)


                }
                
                Spacer()
                
                HStack{
                    Spacer()
                    VStack{
                        Button {
                            isLike.toggle()
                        } label: {
                            VStack{
                                Image(systemName: isLike ? "heart.fill" : "heart")
                                    .font(.title)
                                    .foregroundColor(.white)
                                Text("좋아요")
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .padding(.top, 5)
                            }
                        }
                        .padding(.trailing)
                        .padding(.bottom, 30)
                        
                        Button {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                let location = CLLocation(latitude: self.storyEntity?.latitude ?? 36.014279,
                                                          longitude: self.storyEntity?.longitude ?? 129.325785)
                                print(location)
                                CLGeocoder().reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "Ko-kr")) { placeMark, e in
                                    if let name = placeMark?.first?.name {
                                        self.storyLocationTitle = name
                                    }
                                }
                                onMap = true
                                self.coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.storyEntity?.latitude ?? 36.014279,
                                                                                                          longitude: self.storyEntity?.longitude ?? 129.325785),
                                                                              span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
                                
                                
                            }
                        } label: {
                            VStack{
                                Image(systemName: "map")
                                    .font(.title)
                                    .foregroundColor(.white)
                                Text("위치")
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .padding(.top, 5)
                            }
                        }
                        .padding(.trailing)
                        .padding(.bottom, 100)
                    }
                }
                
                if onMap {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: screenHeight * 0.2)
                }
            }
            
            if onMap {
                VStack{
                    Spacer()
                    
                    ZStack{
                        Button {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                onMap = false
                            }
                        } label: {
                            LinearGradient(colors: [Color.clear, Color.black], startPoint: .top, endPoint: .bottom)
                                .frame(height: screenHeight)
                        }
                        
                        VStack{
                            Spacer()
                            ZStack {
                                if let storyEntity = self.storyEntity {
                                    Map(coordinateRegion: self.$coordinateRegion,
                                        annotationItems: [IdentifiablePlace(storyEntity: storyEntity)]) { pin in
                                        MapAnnotation(coordinate: pin.location) {
                                            PlaceAnnotationView(stroyOn: self.$storyOn, storyEntity: pin.storyEntity)
                                                .disabled(true)
                                        }
                                    }
                                    HStack {
                                        VStack {
                                            HStack {
                                                Image(systemName: "mappin.and.ellipse")
                                                    .resizable()
                                                    .frame(width: 10, height: 10)
                                                    .foregroundColor(.white)
                                                Text("\(self.storyLocationTitle)")
                                                    .font(.caption)
                                                    .foregroundColor(.white)
                                            }
                                            .padding(.horizontal, 5)
                                            .padding(.vertical, 3)
                                            .background(
                                                Capsule(style: .circular)
                                                    .fill(.black)
                                            )
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                    .padding([.top, .leading], 12)
                                }
                            }
                            .padding(.all)
                            .padding(.bottom, 30)
                            .frame(height: screenHeight * 0.3)
                        }
                    }
                }
                .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)))
                
            }
        }
    }
}

//struct StoryWriteView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoryView()
//    }
//}
