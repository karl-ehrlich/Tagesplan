//
//  ActivitiesView.swift
//  Tagesplan
//
//  Created by Karl Ehrlich on 26.08.25.
//

import SwiftUI

struct ActivitiesView: View {
    var activities: [Activity]
    
    var body: some View {
        TimelineView(.animation) { timeline in
            let now = timeline.date
            VStack(spacing: 0) {
                GeometryReader { geo in
                    Canvas { context, size in
                        let startingHour = Calendar.current.date(byAdding: .hour, value: -3, to: now)!
                        let totalHours = 6.0
                        
                        let bottomInset: CGFloat = 20
                        let rowHeight = (size.height - bottomInset) / CGFloat(max(activities.count, 1))
                        
                        let verticalSpacing: CGFloat = 5
                        let barHeight = rowHeight - verticalSpacing
                        let verticalPadding = verticalSpacing / 2
                        
                            // Grid
                        TimeGridView.drawGrid(
                            context: context,
                            size: size,
                            now: now,
                            startingHour: startingHour,
                            totalHours: totalHours,
                            bottomInset: bottomInset
                        )
                        
                            // Activities
                        for (i, activity) in activities.enumerated() {
                            ActivityBar.draw(
                                context: context,
                                size: size,
                                index: i,
                                activity: activity,
                                startingHour: startingHour,
                                totalHours: totalHours,
                                rowHeight: rowHeight,
                                barHeight: barHeight,
                                verticalPadding: verticalPadding
                            )
                        }
                    }
                }
                .frame(height: CGFloat(activities.count) * 35)
            }
        }
    }
}
