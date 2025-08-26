//
//  Activity.swift
//  Tagesplan
//
//  Created by Karl Ehrlich on 26.08.25.
//

import SwiftUI

struct Activity: Identifiable {
    var id = UUID()
    var startTime: Date
    var endTime: Date
    var activityPriority: ActivityPriority
    var activityTitle: String
    var activityDescription: String
}
