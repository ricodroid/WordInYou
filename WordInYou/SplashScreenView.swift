//
//  SplashScreenView.swift
//  WordInYou
//
//  Created by riko on 2025/02/19.
//
import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var animationKey = UUID()
    let splashAnimationFiles = [
        "splash1",
        "splash2"
    ]
    @State private var splashSelectedAnimation: String = UUID().uuidString
    @State private var splashAnimationKey = UUID()

    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)

            VStack {
                LottieView(filename: splashSelectedAnimation, loopMode: .loop)
                    .id(animationKey)
                    .frame(height: 60)
                    .scaleEffect(0.4)
                    .onAppear {
                    DispatchQueue.main.async {
                        splashSelectedAnimation = splashAnimationFiles.randomElement() ?? "splash1"
                        animationKey = UUID()
                    }
                }

                Text("Word In You")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .opacity(isActive ? 1 : 0)
                    .animation(.easeIn(duration: 1.5), value: isActive)
            }
        }
        .onAppear {
            isActive = true

            // 2秒後に遷移
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isActive = false
                }
            }
        }
    }
}
