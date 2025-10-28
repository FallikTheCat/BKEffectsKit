//
//  Starfall.swift
//  BKEffectsKit
//
//  Created by Baturay Koc on 10/13/25.
//

import SwiftUI
import Combine

public struct Star: Identifiable {
    public let id = UUID()
    public var x: CGFloat
    public var y: CGFloat
    public var delay: Double
    public var duration: Double
    public var opacity: Double
}

@MainActor
public class StarViewModel: ObservableObject {
    @Published public var stars: [Star] = []

    public init() {}

    public func generateStars(count: Int, in size: CGSize) {
        stars = (0..<count).map { _ in
            Star(
                x: CGFloat.random(in: 0..<size.width),
                y: -50,
                delay: Double.random(in: 1..<30),
                duration: Double.random(in: 1..<7),
                opacity: Double.random(in: 0.1..<1)
            )
        }

        for index in stars.indices {
            let starIndex = index
            let starDelay = stars[starIndex].delay
            let starDuration = stars[starIndex].duration
            
            DispatchQueue.main.asyncAfter(deadline: .now() + starDelay) { [weak self] in
                guard let self = self else { return }
                
                withAnimation(.easeOut(duration: starDuration)) {
                    if self.stars.indices.contains(starIndex) {
                        self.stars[starIndex].y = CGFloat.random(in: 0..<size.height)
                    }
                }
            }
        }
    }
}

public struct StarfallBackgroundView: View {
    @StateObject private var viewModel = StarViewModel()
    @State private var screenSize: CGSize = .zero
    public var starCount: Int
    public init(starCount: Int) {
        self.starCount = starCount
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(viewModel.stars) { star in
                    Circle()
                        .fill(Color.white.opacity(star.opacity))
                        .frame(width: 2, height: 2)
                        .position(x: star.x, y: star.y)
                }
            }
            .onAppear {
                screenSize = geometry.size
                viewModel.generateStars(count: starCount, in: screenSize)
            }
        }
        .background(
            Color.black
        )
        .ignoresSafeArea()
    }
}
