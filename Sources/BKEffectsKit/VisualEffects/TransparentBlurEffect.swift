//
//  TransparentBlurEffect.swift
//  BKEffectsKit
//
//  Created by Baturay Koc on 10/13/25.
//

import SwiftUI

public struct TransparentBlurEffect: UIViewRepresentable {
    public var removeAllFilters: Bool = false
    
    public init(removeAllFilters: Bool = false) {
        self.removeAllFilters = removeAllFilters
    }
    
    public func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
        
        DispatchQueue.main.async {
            applyFilters(to: view, removeAll: removeAllFilters)
        }
        
        return view
    }
    
    public func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        applyFilters(to: uiView, removeAll: removeAllFilters)
    }
    
    private func applyFilters(to view: UIVisualEffectView, removeAll: Bool) {
        if let backdropLayer = view.layer.sublayers?.first {
            if removeAll {
                backdropLayer.filters = []
            } else {
                backdropLayer.filters?.removeAll(where: { filter in
                    String(describing: filter) != "gaussianBlur"
                })
            }
        }
    }
}
