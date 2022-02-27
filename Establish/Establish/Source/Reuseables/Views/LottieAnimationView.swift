//
//  LottieAnimationView.swift
//  Establish
//
//  Created by Joshua Brown on 06/02/2022.
//

import SwiftUI
import Lottie

struct LottieAnimationView: UIViewRepresentable {
    
    private let assetName: String
    private let loopMode: LottieLoopMode
    
    init(assetName: String, loopMode: LottieLoopMode = .playOnce) {
        self.assetName = assetName
        self.loopMode = loopMode
    }
    
    func makeUIView(context: UIViewRepresentableContext<LottieAnimationView>) -> UIView {
                
        let view = UIView(frame: .zero)
        let animationView = AnimationView()
    
        animationView.animation = Animation.named(assetName)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieAnimationView>) {
        
    }
}
