# EffectsKit

A specialized SwiftUI library for high-performance visual effects, custom animations, transitions and Metal-powered shaders.

---

## ✨ Features

### 🌀 Loading Animations
- **Waiting Dots**: A fluid, bouncing dot sequence for subtle wait states.
- **Loading Orb**: A glowing, pulsing orb effect with customizable blur and scale.
- **Wave Grid**: A grid of shapes that animate in a wave-like pattern—perfect for skeleton screens or data fetching.

### 🌌 Background Effects
- **Starfall**: A dynamic particle system that simulates stars falling through space. Optimized for battery efficiency and high frame rates.

### ⌨️ Text Effects
- **Hacker Text**: Randomized character cycling that "decodes" into your target string.
- **Numeric Transition**: Smoothly animates numbers rolling up or down (ideal for prices or scores).
- **Cycle Texts**: A vertical or cross-fade rotation through a list of strings.
- **Typer Text**: A classic typewriter animation with a customizable cursor.

### 🎨 Visual & Metal Effects
- **GlowHue**: Adds a cycling, neon-like glow to any SwiftUI view.
- **Shimmer**: A premium "shining" overlay for loading states or call-to-action buttons.
- **Transparent Blur**: A high-performance frosted glass effect with adjustable vibrancy.
- **Chaos Lines (Metal)**: A high-performance shader effect using Apple's **Metal** framework to render randomized, flowing lines.

---

## Installation
Swift Package Manager (SPM)
In Xcode, go to File > Add Packages...

Enter the repository URL: [https://github.com/FallikTheCat/BKCustomComponentsKit](https://github.com/FallikTheCat/BKEffectsKit)

Select Up to Next Major Version and click Add Package.

---

## Usage Examples

### Loading Animations
![](Resources_Effects/loading.gif)

- **Waiting Dots**
```swift
WaitingDotsAnimationView(dotCount: 3, dotColor: .black, dotSize: 15, animationDuration: 0.5)
```

- **Loading Orbs**
```swift
LoadingOrbAnimation(size: 45, color: .orange, speed: 1.75, glowOpacity: 1)
```

- **Wave Grid**
```swift
WaveGridAnimation(rows: 4, columns: 4, nodeColor: .black, lineColor: .orange.opacity(0.2), nodeSize: 4, spacing: 10)
```

### Text Effects

- **Hacker Effect**
![](Resources_Effects/hacker.gif)
```swift
HackerTextEffect(text: "Hacker Effect", trigger: trigger, transition: .identity, duration: 3, speed: 0.06)
```

- **Numeric Transition**
![](Resources_Effects/numeric.gif)
```swift
NumericTransitionEffect(value: $number, font: .title3.bold(), color: .black)
```
  
- **Text Cycler**
![](Resources_Effects/slide.gif)
```swift
TextCyclerEffect(messages: messages, cycleDuration: 2.5)
```

- **Typer Effect**
![](Resources_Effects/typer.gif)
```swift
TyperEffect(text: "Typer Effect", interval: 0.2)
```

### Visual Effects

- **Glow Hue Effect**
![](Resources_Effects/glow.gif)
```swift
.glowHueEffect(
    color: Color.orange,
    duration: 2.0,
    opacity: 1.0,
    blurRadius: 20,
    offset: CGSize(width: 0, height: 4)
)
```

- **Shimmer Effect**
![](Resources_Effects/shimmer.gif)
```swift
ZStack {
    RoundedRectangle(cornerRadius: 60)
        .fill(.white)
        .frame(height: 65)
        .padding(.horizontal)
        .shimmerEffect(
            tint: .white.opacity(1),
            highlight: .orange.opacity(0.35),
            blur: 7,
            speed: 3
        )
    Text("Shimmer Effect")
        .font(.title3)
        .bold()
        .foregroundColor(.black)
        .shimmerEffect(
            tint: .black.opacity(1),
            highlight: .white.opacity(0.8),
            blur: 4,
            speed: 4
        )
}
```

- **Transparent Blur Effect**
![](Resources_Effects/transparentblur.gif)
```swift
TransparentBlurEffect(removeAllFilters: false)
  .blur(radius: 24)
  .padding([.horizontal, .top], -50)
  .frame(height: 35 + safeArea.top)
  .visualEffect { view, proxy in
      view
          .offset(y: (proxy.bounds(of: .scrollView)?.minY ?? 0))
  }
  .zIndex(1000)
  .background{
      ZStack{
          RoundedRectangle(cornerRadius: 60)
              .fill(.white)
              .frame(height: 65)
              .padding(.horizontal)
          Text("Transparent Blur")
              .font(.title3)
              .bold()
              .foregroundColor(.black)
      }
      .padding(.top, CGFloat(blurButtonPadding))
  }
  .onAppear{
      startLoopingAnimation()
  }
```

- **Chaos Lines (Metal)**
```swift
TimelineView(.animation) { context in
    RoundedRectangle(cornerRadius: 100)
        .foregroundStyle(.white)
        .colorEffect(
            ShaderLibrary.default.timeLines(
                .boundingRect,
                .float(context.date.timeIntervalSince1970 - self.start.timeIntervalSince1970),
                .float(1))
        )
        .overlay(LinearGradient(gradient: Gradient(colors: [Color(red: 32 / 255, green: 33 / 255, blue: 28 / 255).opacity(1), Color(red: 32 / 255, green: 33 / 255, blue: 28 / 255).opacity(0.3)]), startPoint: .bottom, endPoint: .top))
}
.frame(height: 65)
.cornerRadius(60)
.padding(.horizontal)
.clipped()
```

### Background

- **Starfall**
![](Resources_Effects/starfall.gif)
```swift
StarfallBackgroundView(starCount: 400)
```

---
