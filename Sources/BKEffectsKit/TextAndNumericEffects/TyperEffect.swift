//
//  TyperEffect.swift
//  BKEffectsKit
//
//  Created by Baturay Koc on 10/13/25.
//

import SwiftUI
import Combine


public struct TyperEffect: View {
    public let text: String
    public let interval: Double
    
    @State private var animatedResponse: String = ""
    
    public init(text: String, interval: Double = 0.05) {
        self.text = text
        self.interval = interval
    }
    
    public var body: some View {
        Text(animatedResponse)
            .onAppear {
                startAnimation(for: text)
            }
            .onChange(of: text) { newText in
                animatedResponse = ""
                startAnimation(for: newText)
            }
    }
    
    private func startAnimation(for fullText: String) {
        var currentIndex = 0
        
        func typeNextCharacter() {
            guard currentIndex < fullText.count else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.animatedResponse = ""
                    self.startAnimation(for: fullText)
                }
                return
            }
            let index = fullText.index(fullText.startIndex, offsetBy: currentIndex)
            let character = fullText[index]

            withAnimation(.easeInOut(duration: 0.01)) {
                animatedResponse.append(character)
            }
            
            currentIndex += 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
                typeNextCharacter()
            }
        }
        
        typeNextCharacter()
    }
}
