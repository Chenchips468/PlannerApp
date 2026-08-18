//
//  ContentView.swift
//  PlannerApp
//
//  Created by William Chen on 8/16/26.
//

import SwiftUI
import SwiftData

struct RecordView: View {
    @Binding var navigationPath: NavigationPath
    var taskList: [PlannerTask]
    var date: String
    var body: some View {
        VStack {
            Text("Summary  - " + date)
                .font(.title)
            Text("Completed Tasks:")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(taskList) { task in
                        if(task.isCompleted) {
                            TaskContainer(task: task)
                        }
                    }
                }
                .padding(.horizontal)
            }
            Text("Incomplete Tasks:")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(taskList) { task in
                        if(!task.isCompleted) {
                            TaskContainer(task: task)
                        }
                    }
                }
                .padding(.horizontal)
            }
            Spacer()
        }
    }
}

#Preview {
    @Previewable @State var navigationPath = NavigationPath()
    @Previewable var taskList: [PlannerTask] = []
    RecordView(navigationPath: $navigationPath, taskList: taskList, date: "date")
}
