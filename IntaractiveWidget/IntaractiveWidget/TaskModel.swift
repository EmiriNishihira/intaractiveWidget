//
//  TaskModel.swift
//  IntaractiveWidget
//
//  Created by nakamori on 2023/07/04.
//

import SwiftUI

struct TaskModel: Identifiable {
    var id = UUID().uuidString
    var taskTitle: String
    var isCompleted = false
}

class TaskDataModel {
    static let shared = TaskDataModel()

    var tasks: [TaskModel] = [
        .init(taskTitle: "Record Video")

    ]
}
