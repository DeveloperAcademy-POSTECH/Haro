//
//  HaroApp.swift
//  Haro
//
//  Created by Shin Jae Ung on 2022/04/06.
//

import SwiftUI

@main
struct HaroApp: App {
    var body: some Scene {
        WindowGroup {
            TestView()
        }
    }
}

struct TestView: View {
    @State var minimumScaleFactorValue: Double = 0.5
    @State var frameWidth: CGFloat = 0.5

    var body: some View {
        VStack(spacing: 5) {
            Text("minimumScaleFactorValue : \(self.minimumScaleFactorValue)")
            VStack{
                TestText4(frameWidth: 150 * self.frameWidth)
                TestText4(frameWidth: 150 * self.frameWidth)
                TestText4(frameWidth: 150 * self.frameWidth)
                TestText3(frameWidth: 100 * self.frameWidth)
                TestText3(frameWidth: 100 * self.frameWidth)
                TestText3(frameWidth: 100 * self.frameWidth)
                
            }
            
            TestText(frameWidth: 150 * self.frameWidth, minimumScaleFactorValue: self.minimumScaleFactorValue)
            TestText2(frameWidth: 150 * self.frameWidth, minimumScaleFactorValue: self.minimumScaleFactorValue)
            
            HStack {
                Text("Minimum Scale Factor Value")
                    .lineLimit(2)
                Slider(value: self.$minimumScaleFactorValue, in: 0...1)
            }
            
            HStack {
                Text("Frame Width")
                Slider(value: self.$frameWidth, in: 1...2)
            }
        }
    }
}

struct TestText4: View {
    let fontSize: CGFloat = 25.0
    var frameWidth: CGFloat
//    var minimumScaleFactorValue: Double
    
    init(frameWidth: CGFloat) {//, minimumScaleFactorValue: Double) {
        self.frameWidth = frameWidth
//        self.minimumScaleFactorValue = minimumScaleFactorValue
//        UILabel.appearance().lineBreakMode = .byCharWrapping
        UILabel.appearance().lineBreakStrategy = .pushOut
    }
    
    var body: some View {
        Text("가나다 라마 바 사아자 아자아자 힘내자")
            .font(.system(size: self.fontSize, weight: .bold, design: .default))
//            .minimumScaleFactor(self.minimumScaleFactorValue)
            .lineLimit(5)
            .frame(width: self.frameWidth, height: 50)
            .border(Color.gray)
    }
}

struct TestText3: View {
    let fontSize: CGFloat = 25.0
    var frameWidth: CGFloat
//    var minimumScaleFactorValue: Double
    
    var body: some View {
        Text("가나다 라마 바 사아자 아자아자 힘내자")
            .font(.system(size: self.fontSize, weight: .bold, design: .default))
//            .minimumScaleFactor(self.minimumScaleFactorValue)
            .lineLimit(5)
            .frame(width: self.frameWidth, height: 50)
            .border(Color.gray)
    }
}

struct TestText2: View {
    let fontSize: CGFloat = 30.0
    var frameWidth: CGFloat
    var minimumScaleFactorValue: Double
    
    var body: some View {
        Text("가나다 라마 바 사아자 아자아자 힘내자")
            .font(.system(size: self.fontSize, weight: .bold, design: .default))
            .minimumScaleFactor(self.minimumScaleFactorValue)
            .lineLimit(5)
            .frame(width: self.frameWidth, height: 100)
            .border(Color.gray)
    }
}

struct TestText: View {
    let fontSize: CGFloat = 30.0
    var frameWidth: CGFloat
    var minimumScaleFactorValue: Double
    
    init(frameWidth: CGFloat, minimumScaleFactorValue: Double) {
        self.frameWidth = frameWidth
        self.minimumScaleFactorValue = minimumScaleFactorValue
        UILabel.appearance().lineBreakMode = .byCharWrapping
        UILabel.appearance().lineBreakStrategy = .pushOut
    }
    
    var body: some View {
        Text("가나다 라마 바 사아자 아자아자 힘내자")
            .font(.system(size: self.fontSize, weight: .bold, design: .default))
            .minimumScaleFactor(self.minimumScaleFactorValue)
            .lineLimit(5)
            .frame(width: self.frameWidth, height: 100)
            .border(Color.gray)
    }
}
