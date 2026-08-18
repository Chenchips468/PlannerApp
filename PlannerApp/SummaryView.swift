//
//  ContentView.swift
//  PlannerApp
//
//  Created by William Chen on 8/16/26.
//

import SwiftUI
import SwiftData

struct SummaryView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var navigationPath: NavigationPath
    @Query(filter: #Predicate<PlannerTask> { $0.isArchived == false })private var taskList: [PlannerTask]
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
            Button(action: {
                print("Next Day Button")
                var newRecord = Record(date: date, taskList: taskList)
                modelContext.insert(newRecord)
                if !navigationPath.isEmpty {
                    navigationPath.removeLast()
                }
                for task in taskList {
                    task.isArchived = true
                }
            }) {
                Text("Next Day")
                    .multilineTextAlignment(.center)
                    .frame(width: 100, height: 100)
            }
            .buttonStyle(.borderedProminent)
            .tint(.gray)
        }
    }
}

struct TaskContainer: View {
    var task: PlannerTask
    var body: some View {
        HStack{
            Button(action: {
                print("Tapped ID: \(task.id)")
            }) {
                HStack{
                    Text(task.name)
                    Spacer()
                    Text(task.isCompleted ? "Complete":"Incomplete")
                }.padding()
            }
            .buttonStyle(.borderedProminent)
            .tint(task.isCompleted ? .green : .gray)
        }
    }
}

#Preview {
    @Previewable @State var navigationPath = NavigationPath()
    SummaryView(navigationPath: $navigationPath, date: "date").modelContainer(for:[Record.self, PlannerTask.self], inMemory: true)
}
