//
//  ActivityPriority.swift
//  Tagesplan
//
//  Created by Karl Ehrlich on 26.08.25.
//

import SwiftUI

enum ActivityPriority: CaseIterable {
    case low, medium, high
    
    var color: Color {
        switch self {
            case .low: return .green
            case .medium: return .orange
            case .high: return .red
        }
    }
}
