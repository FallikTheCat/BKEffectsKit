//
//  WaitingDotsAnimation.swift
//  BKEffectsKit
//
//  Created by Baturay Koc on 10/17/25.
//

import SwiftUI

public struct WaitingDotsAnimationView: View {
    @State private var shouldAnimate = false
    
    private let dotCount: Int
    private let dotColor: Color
    private let dotSize: CGFloat
    private let animationDuration: Double
    
    public init(
        dotCount: Int = 3,
        dotColor: Color = .black,
        dotSize: CGFloat = 15,
        animationDuration: Double = 0.5
    ) {
        self.dotCount = dotCount
        self.dotColor = dotColor
        self.dotSize = dotSize
        self.animationDuration = animationDuration
    }
    
    public var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<dotCount, id: \.self) { index in
                Circle()
                    .fill(dotColor)
                    .frame(width: dotSize, height: dotSize)
                    .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                    .animation(
                        Animation.easeInOut(duration: animationDuration)
                            .repeatForever()
                            .delay(Double(index) * 0.3),
                        value: shouldAnimate
                    )
            }
        }
        .onAppear { shouldAnimate = true }
        .onDisappear { shouldAnimate = false }
        .padding()
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.horizontal, 35)
        .padding(.vertical, 7)
    }
}
