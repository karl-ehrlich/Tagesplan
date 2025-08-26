//
//  ContentView.swift
//  Tagesplan
//
//  Created by Karl Ehrlich on 26.08.25.
//

import SwiftUI

struct ActivityCreationView: View {
    
    @Environment(\.dismiss)
    private var dismiss
    
    @Binding
    var activities: [Activity]
    
    
    @State private var title: String = ""
    @State private var description: String = ""
    
    @State private var startTime: Date = .now
    @State private var endTime: Date = .now.addingTimeInterval(60 * 60)
    
    @State private var priority: ActivityPriority = .medium
    
    var allowCreation: Bool {
        
        guard !title.isEmpty else { return false }
        guard startTime < endTime else { return false }
        
        return true
    }
    
    var body: some View {
        NavigationStack {
            
            List {
                
                Section("Information") {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description, axis: .vertical)
                }
                
                Section("Duration") {
                    HStack {
                        DatePicker(
                            "Start Time",
                            selection: $startTime,
                            displayedComponents: .hourAndMinute
                        )
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        
                        Image(systemName: "arrow.right")
                            .foregroundStyle(.secondary)
                            .frame(
                                maxWidth: .infinity,
                                alignment: .center
                            )
                        
                        
                        DatePicker(
                            "End Time",
                            selection: $endTime,
                            displayedComponents: .hourAndMinute
                        )
                        .datePickerStyle(.compact)
                        .labelsHidden()
                    }
                }
                
                Section("Priority") {
                    Picker("Priority", selection: $priority) {
                        Text("Low") .tag(ActivityPriority.low)
                        Text("Medium") .tag(ActivityPriority.medium)
                        Text("High") .tag(ActivityPriority.high)
                    } .pickerStyle(.segmented)
                }
                
            }
            .navigationTitle("New Event")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Create") {
                        
                        let newActivity = Activity(
                            startTime: startTime,
                            endTime: endTime,
                            activityPriority: priority,
                            activityTitle: title,
                            activityDescription: description
                        )
                        
                        activities.append(newActivity)
                        
                        dismiss()
                    } .disabled(!allowCreation)
                }
            }
        }
    }
}

struct ContentView: View {
    
    @State private var displayCreationSheet = true
    @State private var activities = [Activity]()
    
    var body: some View {
        NavigationStack {
            
            List {
                
                
                
                Section("Di. 26. Aug.") {
                   ActivitiesView(activities: activities)
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
            .sheet(isPresented: $displayCreationSheet) {
                ActivityCreationView(activities: $activities)
            }
        }
    }
}

#Preview {
    ContentView()
}
