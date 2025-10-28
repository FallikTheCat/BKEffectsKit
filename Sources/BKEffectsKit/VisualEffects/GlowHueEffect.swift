//
//  GlowHueEffect.swift
//  BKEffectsKit
//
//  Created by Baturay Koc on 10/13/25.
//

import SwiftUI

public struct GlowHueEffect: ViewModifier {
    @State private var hueRotation: Double = 0.0
    public let color: Color
    public let duration: Double
    public let opacity: Double
    public let blurRadius: CGFloat
    public let offset: CGSize
    
    public init(color: Color, duration: Double = 4.0, opacity: Double = 0.4, blurRadius: CGFloat = 24, offset: CGSize = CGSize(width: 4, height: 8)) {
        self.color = color
        self.duration = duration
        self.opacity = opacity
        self.blurRadius = blurRadius
        self.offset = offset
    }
    
    public func body(content: Content) -> some View {
        content
            .background(
                AngularGradient(
                    gradient: Gradient(stops: [
                        .init(color: color, location: 0),
                        .init(color: color.opacity(opacity), location: 0.25),
                        .init(color: color.opacity(opacity), location: 0.5),
                        .init(color: color.opacity(opacity), location: 0.75),
                        .init(color: color, location: 1)
                    ]),
                    center: .center,
                    angle: Angle(degrees: hueRotation * 360)
                )
                .blur(radius: blurRadius)
                .opacity(opacity)
                .offset(offset)
                .padding()
                .onAppear {
                    withAnimation(.linear(duration: duration).repeatForever(autoreverses: true)) {
                        hueRotation += 1.0
                    }
                }
            )
            .shadow(color: color.opacity(0.1), radius: blurRadius, x: offset.width, y: offset.height)
    }
}

public extension View {
    func glowHueEffect(color: Color, duration: Double = 4.0, opacity: Double = 0.4, blurRadius: CGFloat = 24, offset: CGSize = CGSize(width: 4, height: 8)) -> some View {
        modifier(GlowHueEffect(color: color, duration: duration, opacity: opacity, blurRadius: blurRadius, offset: offset))
    }
}
