//
//  TextCyclerEffect.swift
//  BKEffectsKit
//
//  Created by Baturay Koc on 10/13/25.
//

import SwiftUI

public struct TextCyclerEffect: View {
    public let messages: [String]
    public let cycleDuration: Double
    
    @State private var textIndex: Int = 0
    
    public init(messages: [String], cycleDuration: Double = 2.0) {
        self.messages = messages
        self.cycleDuration = cycleDuration
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 60)
                .fill(.white)
                .frame(height: 65)
                .padding(.horizontal)
            
            Text(messages[textIndex])
                .font(.title3)
                .bold()
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .transition(.asymmetric(
                    insertion: .move(edge: .bottom).combined(with: .opacity),
                    removal: .move(edge: .top).combined(with: .opacity)
                ))
                .id(textIndex)
                .animation(.easeInOut(duration: 0.6), value: textIndex)
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: cycleDuration, repeats: true) { _ in
                        withAnimation {
                            textIndex = (textIndex + 1) % messages.count
                        }
                    }
                }
                .padding()
        }
    }
}
