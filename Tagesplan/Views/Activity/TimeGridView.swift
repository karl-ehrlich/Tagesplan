//
//  TimeGridView.swift
//  Tagesplan
//
//  Created by Karl Ehrlich on 26.08.25.
//

import SwiftUI

enum TimeGridView {
    static func drawGrid(
        context: GraphicsContext,
        size: CGSize,
        now: Date,
        startingHour: Date,
        totalHours: Double,
        bottomInset: CGFloat
    ) {
        let spacing = size.width / CGFloat(totalHours)
        var path = Path()
        
        for h in 0...Int(totalHours) {
            let x = spacing * CGFloat(h)
            path.move(to: CGPoint(x: x, y: 0))
            path.addLine(to: CGPoint(x: x, y: size.height - bottomInset))
            
            let displayHour = Calendar.current.date(byAdding: .hour, value: h - 3, to: now)!
            let hourComp = Calendar.current.component(.hour, from: displayHour)
            
            let label = Text("\(hourComp):00")
                .font(.caption2)
                .foregroundStyle(.secondary)
            let resolved = context.resolve(label)
            let textSize = resolved.measure(in: size)
            let rect = CGRect(
                x: x - textSize.width / 2,
                y: size.height - bottomInset + (bottomInset - textSize.height) / 2,
                width: textSize.width,
                height: textSize.height
            )
            context.draw(resolved, in: rect)
        }
        context.stroke(path, with: .color(.secondary), lineWidth: 1)
    }
}
