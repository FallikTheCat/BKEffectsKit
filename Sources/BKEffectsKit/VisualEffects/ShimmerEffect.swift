//
//  ShimmerEffect.swift
//  BKEffectsKit
//
//  Created by Baturay Koc on 10/13/25.
//

import SwiftUI

private struct ShimmerEffect: ViewModifier {
    public var tint: Color
    public var highlight: Color
    public var blur: CGFloat = 0
    public var highlightOpacity: CGFloat = 1
    public var speed: CGFloat = 10
    
    public init(tint: Color, highlight: Color, blur: CGFloat = 0, highlightOpacity: CGFloat = 1, speed: CGFloat = 10) {
        self.tint = tint
        self.highlight = highlight
        self.blur = blur
        self.highlightOpacity = highlightOpacity
        self.speed = speed
    }
    
    @State private var moveTo: CGFloat = -3
    func body(content: Content) -> some View {
        content
            .hidden()
            .overlay{
                Rectangle()
                    .fill(tint)
                    .mask{
                        content
                    }
                    .overlay{
                        GeometryReader {
                            let size = $0.size
                            
                            Rectangle()
                                .fill(
                                    .linearGradient(colors: [.white.opacity(0), highlight.opacity(highlightOpacity), .white.opacity(0)], startPoint: .top, endPoint: .bottom)
                                )
                                .blur(radius: blur)
                                .rotationEffect(.init(degrees: -70))
                                .offset(x: size.width * moveTo)
                        }
                    }
                    .mask{
                        content
                    }
            }
            .onAppear{
                DispatchQueue.main.async {
                    moveTo = 3
                }
            }
            .animation(.linear(duration: speed).repeatForever(autoreverses: false), value: moveTo)
    }
}

public extension View {
    func shimmerEffect(tint: Color, highlight: Color, blur: CGFloat = 0, highlightOpacity: CGFloat = 1, speed: CGFloat = 10) -> some View {
        modifier(ShimmerEffect(tint: tint, highlight: highlight, blur: blur, highlightOpacity: highlightOpacity, speed: speed))
    }
}
