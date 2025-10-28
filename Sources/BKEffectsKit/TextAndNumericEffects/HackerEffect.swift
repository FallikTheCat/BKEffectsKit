//
//  HackerEffect.swift
//  BKEffectsKit
//
//  Created by Baturay Koc on 10/13/25.
//

import SwiftUI

public struct HackerTextEffect: View {
    public var text: String
    public var trigger: Bool
    public var transition: ContentTransition
    public var duration: CGFloat
    public var speed: CGFloat
    
    public init(text: String, trigger: Bool = false, transition: ContentTransition = .interpolate, duration: CGFloat = 1.0, speed: CGFloat = 0.1) {
        self.text = text
        self.trigger = trigger
        self.transition = transition
        self.duration = duration
        self.speed = speed
    }
    
    @State private var animatedText: String = ""
    @State private var randomCharacters: [Character] = {
        let string = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return Array(string)
    }()
    
    public var body: some View {
        Text(animatedText)
            .font(.title3)
            .bold()
            .foregroundStyle(.black)
            .truncationMode(.tail)
            .multilineTextAlignment(.center)
            .contentTransition(transition)
            .onAppear{
                guard animatedText.isEmpty else {return}
                setRandomCharacters()
                animateText()
            }
            .onChange(of: trigger) { oldValue, newValue in
                animateText()
            }
    }
    
    private func animateText() {
        for index in text.indices {
            let delay = CGFloat.random(in: 0...duration)
            let timer = Timer.scheduledTimer(withTimeInterval: speed, repeats: true) { _ in
                guard let randomCharacter = randomCharacters.randomElement() else {return}
                replaceCharacter(at: index, character: randomCharacter)
            }
            timer.fire()
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                if text.indices.contains(index) {
                    let actualCharacter = text[index]
                    replaceCharacter(at: index, character: actualCharacter)
                }
                
                timer.invalidate()
            }
        }
    }
    
    private func setRandomCharacters() {
        animatedText = text
        for index in animatedText.indices {
            guard let randomCharacter = randomCharacters.randomElement() else {return}
            replaceCharacter(at: index, character: randomCharacter)
        }
    }
    
    func replaceCharacter(at index: String.Index, character: Character) {
        guard animatedText.indices.contains(index) else {return}
        let indexCharacter = String(animatedText[index])
        
        if indexCharacter.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            animatedText.replaceSubrange(index...index, with: String(character))
        }
    }
}
