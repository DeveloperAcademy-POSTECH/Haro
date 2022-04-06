//
//  StoryWriteView.swift
//  Haro
//
//  Created by Shin Jae Ung on 2022/04/06.
//

import SwiftUI
import MapKit

struct StoryWriteView: View {
    @State var coordinateRegion: MKCoordinateRegion = MKCoordinateRegion ( center: CLLocationCoordinate2D ( latitude: 36.014279, longitude: 129.325785 ), span: MKCoordinateSpan ( latitudeDelta: 0.005, longitudeDelta: 0.005 ) )
    @State var onMap = false
    
    let screenHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
        ZStack{
            Image("back")
                .resizable()
                .ignoresSafeArea()
            
            VStack{
                HStack {
                    ZStack{
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
                    VStack(alignment: .leading) {
                        Text("이름이름")
                            .font(.body)
                            .foregroundColor(.white)
                        Text("맛집")
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                    
                    Button {
                        Void()
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
                            Void()
                        } label: {
                            VStack{
                                Image(systemName: "heart")
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
                                onMap.toggle()
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
                    Map(coordinateRegion: $coordinateRegion)
                        .padding(.all)
                        .frame(height: screenHeight * 0.3)
                        .transition(.move(edge: .bottom))
                }
            }
        }
    }
}

struct StoryWriteView_Previews: PreviewProvider {
    static var previews: some View {
        StoryWriteView()
    }
}
