//
//  NumericTransitionEffect.swift
//  BKEffectsKit
//
//  Created by Baturay Koc on 10/17/25.
//

import SwiftUI

public struct NumericTransitionEffect: View {
    @Binding public var value: Int
    public var font: Font
    public var color: Color
    
    public init(value: Binding<Int>,
                font: Font = .title3.bold(),
                color: Color = .primary) {
        self._value = value
        self.font = font
        self.color = color
    }
    
    public var body: some View {
        Text("\(value)")
            .font(font)
            .foregroundColor(color)
            .contentTransition(.numericText(value: Double(value)))
    }
}
