//
//  ContentView.swift
//  Tagesplan
//
//  Created by Karl Ehrlich on 26.08.25.
//

import SwiftUI

struct ActivityCreationView: View {
    var body: some View {
        Text("test123")
    }
}

struct ContentView: View {
    
    @State private var displayCreationSheet = false
    
    var body: some View {
        NavigationStack {
            
            List {
                
                if false {
                    HStack {
                        
                        ProgressView()
                            .padding(.trailing, 5)
                        
                        VStack(alignment: .leading) {
                            Text("Synchronisierung läuft")
                                .font(.headline)
                            Text("Beide Geräte eingeschaltet lassen")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        
                    }
                }
                
                
                Section("Di. 26. Aug.") {
                    let now = Date()
                    let mockActivities: [Activity] = [
                        Activity(
                            startTime: Calendar.current.date(byAdding: .minute, value: -90, to: now)!,
                            endTime: Calendar.current.date(byAdding: .minute, value: -30, to: now)!,
                            activityPriority: .low,
                            activityTitle: "Breakfast",
                            activityDescription: "Quick meal"
                        ),
                        Activity(
                            startTime: Calendar.current.date(byAdding: .minute, value: -15, to: now)!,
                            endTime: Calendar.current.date(byAdding: .minute, value: 90, to: now)!,
                            activityPriority: .medium,
                            activityTitle: "Work Session",
                            activityDescription: "Focus time"
                        ),
                        Activity(
                            startTime: Calendar.current.date(byAdding: .minute, value: 120, to: now)!,
                            endTime: Calendar.current.date(byAdding: .minute, value: 180, to: now)!,
                            activityPriority: .high,
                            activityTitle: "Meeting",
                            activityDescription: "Team sync"
                        )
                    ]
                    
                    ActivitiesView(activities: mockActivities)
                }
            }
            .navigationTitle("Tagesplan")
            .toolbar {
                
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button {
                        
                    } label: {
                        Label("Settings", systemImage: "gear")
                    } //.disabled(true)
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    
                    Button {
                        
                    } label: {
                        Label("Share Event", systemImage: "square.and.arrow.up")
                    } //.disabled(true)
                    
                    Button {
                        displayCreationSheet.toggle()
                    } label: {
                        Label("New Event", systemImage: "plus")
                    } //.disabled(true)
                }
            }
        }
        .sheet(isPresented: $displayCreationSheet) {
            ActivityCreationView()
        }
    }
}

#Preview {
    ContentView()
}
