//
//  HexMeshAnimation.swift
//  BKEffectsKit
//
//  Created by Baturay Koc on 10/17/25.
//

import SwiftUI

public struct WaveGridAnimation: View {
    public var rows: Int = 6
    public var columns: Int = 6
    public var nodeColor: Color = Color(red: 0.68, green: 0.95, blue: 0.12)
    public var lineColor: Color = Color.white.opacity(0.2)
    public var nodeSize: CGFloat = 10
    public var spacing: CGFloat = 30

    @State private var pulses: [[Bool]] = []

    public init(rows: Int = 6,
                columns: Int = 6,
                nodeColor: Color = Color(red: 0.68, green: 0.95, blue: 0.12),
                lineColor: Color = Color.white.opacity(0.2),
                nodeSize: CGFloat = 10,
                spacing: CGFloat = 30) {
        self.rows = rows
        self.columns = columns
        self.nodeColor = nodeColor
        self.lineColor = lineColor
        self.nodeSize = nodeSize
        self.spacing = spacing
        _pulses = State(initialValue: Array(repeating: Array(repeating: false, count: columns), count: rows))
    }

    public var body: some View {
        GeometryReader { geo in
            let totalWidth = CGFloat(columns - 1) * spacing
            let totalHeight = CGFloat(rows - 1) * spacing
            let offsetX = (geo.size.width - totalWidth) / 2
            let offsetY = (geo.size.height - totalHeight) / 2

            ZStack {
                ForEach(0..<rows, id: \.self) { i in
                    ForEach(0..<columns, id: \.self) { j in
                        Circle()
                            .fill(nodeColor)
                            .frame(width: pulses[i][j] ? nodeSize * 1.5 : nodeSize,
                                   height: pulses[i][j] ? nodeSize * 1.5 : nodeSize)
                            .position(
                                x: offsetX + CGFloat(j) * spacing,
                                y: offsetY + CGFloat(i) * spacing
                            )
                            .animation(
                                .easeInOut(duration: Double.random(in: 0.6...1.2))
                                    .repeatForever(autoreverses: true),
                                value: pulses[i][j]
                            )
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0...1.5)) {
                                    pulses[i][j].toggle()
                                }
                            }
                    }
                }

                ForEach(0..<rows, id: \.self) { i in
                    ForEach(0..<columns, id: \.self) { j in
                        if i < rows - 1 {
                            Line(from: CGPoint(x: offsetX + CGFloat(j) * spacing, y: offsetY + CGFloat(i) * spacing),
                                 to: CGPoint(x: offsetX + CGFloat(j) * spacing, y: offsetY + CGFloat(i+1) * spacing))
                                .stroke(lineColor, lineWidth: 1)
                        }
                        if j < columns - 1 {
                            Line(from: CGPoint(x: offsetX + CGFloat(j) * spacing, y: offsetY + CGFloat(i) * spacing),
                                 to: CGPoint(x: offsetX + CGFloat(j+1) * spacing, y: offsetY + CGFloat(i) * spacing))
                                .stroke(lineColor, lineWidth: 1)
                        }
                    }
                }
            }
        }
    }
}

struct Line: Shape {
    var from: CGPoint
    var to: CGPoint

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: from)
        path.addLine(to: to)
        return path
    }
}
