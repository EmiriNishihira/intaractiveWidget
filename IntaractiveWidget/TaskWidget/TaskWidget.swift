//
//  TaskWidget.swift
//  TaskWidget
//
//  Created by nakamori on 2023/07/04.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> TaskEntry {
        TaskEntry(lastThreeTasks: Array(TaskDataModel.shared.tasks.prefix(3)))
    }

    func getSnapshot(in context: Context, completion: @escaping (TaskEntry) -> ()) {
        let entry = TaskEntry(lastThreeTasks: Array(TaskDataModel.shared.tasks.prefix(3)))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<TaskEntry>) -> ()) {
        // Fetch data
        let latestTasks = Array(TaskDataModel.shared.tasks.prefix(3))
        let latestEntries = [TaskEntry(lastThreeTasks: latestTasks)]
        let timeline = Timeline(entries: latestEntries, policy: .atEnd)
        completion(timeline)
    }
}

struct TaskEntry: TimelineEntry {
    let date: Date = .now
    let lastThreeTasks: [TaskModel]
}

struct TaskWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {

            VStack(alignment: .leading, spacing: 6, content: {
                if entry.lastThreeTasks.isEmpty {
                    Text("No Task's Found")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ForEach(entry.lastThreeTasks) { task in
                        HStack(spacing: 6) {
                            if task.isCompleted {
                                ContentView2(entry: entry)
                            }
                            if !task.isCompleted {

                                VStack(alignment: .leading, spacing: 4, content: {


                                    Button(intent: ToggleStateIntent(id: task.id)) {

                                        VStack {
                                            HStack {
                                                Image(task.isCompleted ? "pain1" : "pain1")
                                                    .foregroundStyle(.blue)

                                                Image(task.isCompleted ? "pain2" : "pain2")
                                                    .foregroundStyle(.blue)
                                            }
                                            HStack {
                                                Image(task.isCompleted ? "pain3" : "pain3")
                                                    .foregroundStyle(.blue)

                                                Image(task.isCompleted ? "pain4" : "pain4")
                                                    .foregroundStyle(.blue)
                                            }
                                        }



                                    }
                                    .buttonStyle(.plain)

                                })
                            }
                        }

                        if task.id != entry.lastThreeTasks.last?.id {
                            Spacer(minLength: 0)
                        }
                        
                    }
                }
            })
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

struct TaskWidget: Widget {
    let kind: String = "TaskWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TaskWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Task Widget")
        .description("This is an example of interactive widget.")
    }
}

#Preview(as: .systemSmall) {
    TaskWidget()
} timeline: {
    TaskEntry(lastThreeTasks: TaskDataModel.shared.tasks)
}
