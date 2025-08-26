//
//  ActivityBar.swift
//  Tagesplan
//
//  Created by Karl Ehrlich on 26.08.25.
//

import SwiftUI

enum ActivityBar {
    static func draw(
        context: GraphicsContext,
        size: CGSize,
        index: Int,
        activity: Activity,
        startingHour: Date,
        totalHours: Double,
        rowHeight: CGFloat,
        barHeight: CGFloat,
        verticalPadding: CGFloat
    ) {
        let y = rowHeight * CGFloat(index) + verticalPadding
        let h = barHeight
        let labelPadding: CGFloat = 4
        
        func normalizedX(for date: Date) -> CGFloat {
            let secondsFromStart = date.timeIntervalSince(startingHour)
            let fraction = secondsFromStart / (6*3600)
            return max(0, min(1, fraction)) * size.width
        }
        
        let startX = normalizedX(for: activity.startTime)
        let endX   = normalizedX(for: activity.endTime)
        guard endX > startX else { return }
        
        let rect = CGRect(x: startX, y: y, width: endX - startX, height: h)
        let barShape = Path(roundedRect: rect, cornerRadius: 4)
        context.fill(barShape, with: .color(activity.activityPriority.color))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let startText = Text(formatter.string(from: activity.startTime))
            .font(.caption2)
            .foregroundStyle(.white)
        let endText = Text(formatter.string(from: activity.endTime))
            .font(.caption2)
            .foregroundStyle(.white)
        
        let startResolved = context.resolve(startText)
        let endResolved = context.resolve(endText)
        let startSize = startResolved.measure(in: size)
        let endSize = endResolved.measure(in: size)
        
        if (endX - startX) > (startSize.width + endSize.width + 2*labelPadding) &&
            Calendar.current.component(.minute, from: activity.endTime) != 0 {
            let startPoint = CGPoint(x: rect.minX + labelPadding,
                                     y: y + h/2)
            let endPoint = CGPoint(x: rect.maxX - labelPadding,
                                   y: y + h/2)
            context.draw(startResolved, at: startPoint, anchor: .leading)
            context.draw(endResolved, at: endPoint, anchor: .trailing)
        }
    }
}
