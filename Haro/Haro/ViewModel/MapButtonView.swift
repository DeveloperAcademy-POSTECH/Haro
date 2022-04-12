//
//  MapButtonView.swift
//  Haro
//
//  Created by Moon Jongseek on 2022/04/06.
//

import SwiftUI
import CoreLocationUI

struct MapButtonView: View {
    @Binding var showingCategoryView: Bool
    @ObservedObject var mapViewModel: MapViewModel
    
    var body: some View {
        HStack{
            Spacer()
            VStack {
                MapButton(name: "square.grid.3x2") {
                    self.showingCategoryView.toggle()
                }
                
//                MapButton(name: "arkit") {
//                    print("ARKit")
//                }
//                MapButton(name: "square.grid.3x2") {
//                    print("Category Button")
//                }
                LocationButton(.currentLocation) {
                        self.mapViewModel.requestWhenInUseAuthzorization()
                }
                .foregroundColor(.black)
                .tint(.white)
                .cornerRadius(8)
                .font(.system(size: 26))
                .labelStyle(.iconOnly)
                
                Spacer()
            }
            .padding(16)
        }
    }
}

struct MapButton: View {
    let buttonSize: CGFloat = 60
    var imageName: String
    var buttonAction: () -> Void
    
    init(name: String, buttonAction: @escaping () -> Void) {
        self.imageName = name
        self.buttonAction = buttonAction
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.white)
                .frame(width: 60, height: 60)
                .shadow(color: .gray, radius: 1, x: 0, y: 0.5)
                .overlay(
                    RoundedRectangle(cornerRadius: 17)
                        .stroke(.gray, lineWidth: 1)
                )
            Button(action: self.buttonAction) {
                Image(systemName: self.imageName)
                    .foregroundColor(.black)
            }
        }
        .frame(width: self.buttonSize, height: self.buttonSize)
    }
}

//struct MapButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapButtonView()
//    }
//}
