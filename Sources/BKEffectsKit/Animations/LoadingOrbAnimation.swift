//
//  LoadingOrbAnimation.swift
//  BKEffectsKit
//
//  Created by Baturay Koc on 10/17/25.
//

import SwiftUI

public struct LoadingOrbAnimation: View {
    public var size: CGFloat
    public var color: Color
    public var speed: Double
    public var glowOpacity: Double
    public var shadowColor: Color

    @State private var rotateOuter = false
    @State private var pulse = false

    public init(
        size: CGFloat = 60,
        color: Color = Color(red: 175/255, green: 243/255, blue: 31/255),
        speed: Double = 3,
        glowOpacity: Double = 0.8,
        shadowColor: Color = .black.opacity(0.5)
    ) {
        self.size = size
        self.color = color
        self.speed = speed
        self.glowOpacity = glowOpacity
        self.shadowColor = shadowColor
    }

    public var body: some View {
        ZStack {
            Circle()
                .strokeBorder(
                    AngularGradient(
                        gradient: Gradient(colors: [color, .white, color, .white]),
                        center: .center
                    ),
                    lineWidth: 3
                )
                .frame(width: size, height: size)
                .rotationEffect(.degrees(rotateOuter ? 180 : -180))
                .blur(radius: 0.5)
                .opacity(glowOpacity)
                .animation(.linear(duration: speed).repeatForever(autoreverses: false), value: rotateOuter)
            
            Circle()
                .strokeBorder(
                    AngularGradient(
                        gradient: Gradient(colors: [color, .black, color, .black]),
                        center: .center
                    ),
                    lineWidth: 3
                )
                .frame(width: size * 0.67, height: size * 0.67)
                .rotationEffect(.degrees(rotateOuter ? 360 : 0))
                .blur(radius: 0.5)
                .opacity(glowOpacity)
                .animation(.linear(duration: speed).repeatForever(autoreverses: false), value: rotateOuter)

            // Inner pulsing orb
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color.black.opacity(0.8),
                            color.opacity(0.4)
                        ]),
                        center: .center,
                        startRadius: 5,
                        endRadius: size * 0.67
                    )
                )
                .frame(width: pulse ? size * 0.28 : size * 0.38,
                       height: pulse ? size * 0.28 : size * 0.38)
                .shadow(color: shadowColor, radius: 12)
                .scaleEffect(pulse ? 1.05 : 0.95)
                .animation(.easeInOut(duration: speed / 2.5).repeatForever(), value: pulse)
        }
        .onAppear {
            rotateOuter = true
            pulse = true
        }
    }
}
