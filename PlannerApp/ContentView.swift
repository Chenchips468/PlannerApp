//
//  ContentView.swift
//  PlannerApp
//
//  Created by William Chen on 8/16/26.
//

import Foundation
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State var navigationPath = NavigationPath()
    @Query(filter: #Predicate<PlannerTask> { $0.isArchived == false }) private var taskList: [PlannerTask]
    @Query var recordList: [Record]
    var body: some View {
        NavigationStack(path: $navigationPath){
            VStack {
                Text(
                    "Daily Tasks - " + Date.now.formatted(date: .abbreviated, time: .omitted)
                )
                .font(.largeTitle)
                .padding(5)
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(taskList) { task in
                            TaskWidget(navigationPath: $navigationPath, task: task)
                        }
                    }
                    .padding(.horizontal)
                }
                Spacer()
                BottomBar(
                    navigationPath: $navigationPath
                )
            }
            .navigationDestination(for: String.self) { value in
                if value == "TaskPage" {
                    TaskPage(navigationPath: $navigationPath)
                }
                else if value == "SummaryView" {
                    SummaryView(
                        navigationPath: $navigationPath,
                        date: Date.now.formatted(date: .abbreviated, time: .omitted)
                    )
                }
                else if value == "Records" {
                    RecordsView(navigationPath: $navigationPath)
                }
            }
            .navigationDestination(for: PlannerTask.self) { selectedTask in
                if let index = taskList.firstIndex(where: { $0.id == selectedTask.id }) {
                    TaskCompletePage(navigationPath: $navigationPath, task: taskList[index])
                    }
                }
            .navigationDestination(for: Record.self) { selectedRecord in
                if let index = recordList.firstIndex(where: { $0.id == selectedRecord.id }) {
                    RecordView(navigationPath: $navigationPath, taskList: recordList[index].taskList, date: selectedRecord.date)
                    }
                }
        }
    }
}

struct BottomBar: View {
    @Binding var navigationPath: NavigationPath
    var body: some View {
        HStack {
            Button(action: {
                navigateToNextPage(page:"TaskPage")
            }) {
                Text("Create Task")
                    .multilineTextAlignment(.center)
                    .frame(width: 100, height: 100)
            }
            .buttonStyle(.borderedProminent)
            .tint(.gray)
            Button(action: {
                navigateToNextPage(page:"SummaryView")
            }) {
                Text("Finish Day")
                    .multilineTextAlignment(.center)
                    .frame(width: 100, height: 100)
            }
            .buttonStyle(.borderedProminent)
            .tint(.gray)
            Button(action: {
                navigateToNextPage(page:"Records")
            }) {
                Text("Records")
                    .multilineTextAlignment(.center)
                    .frame(width: 100, height: 100)
            }
            .buttonStyle(.borderedProminent)
            .tint(.gray)
        }
        .padding()
    }
    func navigateToNextPage(page:String) {
            print("Function called! Performing actions before moving to "+page)
            navigationPath.append(page)
        }
}


struct TaskWidget: View {
    @Binding var navigationPath: NavigationPath
    var task: PlannerTask
    var body: some View {
        HStack{
            Button(action: {
                print("Tapped ID: \(task.id)")
                navigateToTaskComplete(task: task)
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
    func navigateToTaskComplete(task:PlannerTask) {
        print("Function called! Performing actions before moving to "+task.name)
        navigationPath.append(task)
    }
}


@Model
final class Record: Identifiable, Hashable{
    var id:UUID = UUID()
    var date: String = ""
    var taskList: [PlannerTask] = []

    init(date: String, taskList: [PlannerTask]) {
        self.date = date
        self.taskList = taskList
    }
}

@Model
final class PlannerTask: Identifiable, Hashable{
    var id:UUID = UUID()
    public var name: String = ""
    public var isCompleted: Bool = false
    public var details: String = ""
    public var isArchived: Bool = false

    init(name: String, isCompleted: Bool = false, details: String) {
        self.name = name
        self.isCompleted = isCompleted
        self.details = details
    }
    
    static func == (lhs: PlannerTask, rhs: PlannerTask) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
#Preview {
    ContentView().modelContainer(for:[Record.self, PlannerTask.self], inMemory: true)
}
