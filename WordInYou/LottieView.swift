//
//  LottieView.swift
//  WordInYou
//
//  Created by riko on 2025/02/18.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let filename: String
    let loopMode: LottieLoopMode

    func makeUIView(context: Context) -> LottieAnimationView {
        let animationView = LottieAnimationView()
        let animation = LottieAnimation.named(filename)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()
        return animationView
    }

    func updateUIView(_ uiView: LottieAnimationView, context: Context) {}
}


