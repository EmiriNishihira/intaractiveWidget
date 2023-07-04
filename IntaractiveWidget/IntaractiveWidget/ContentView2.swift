//
//  ContentView2.swift
//  IntaractiveWidget
//
//  Created by nakamori on 2023/07/04.
//

import SwiftUI

struct ContentView2: View {
    var entry: Provider.Entry
    var body: some View {
        ForEach(entry.lastThreeTasks) { task in
            Button(intent: ToggleStateIntent(id: task.id)) {
                
                Image(systemName: task.isCompleted ? "chevron.left" : "circle")
                    .foregroundStyle(.blue)
                
            }
            .buttonStyle(.plain)
            Text("記録しました")
        }
    }
}

