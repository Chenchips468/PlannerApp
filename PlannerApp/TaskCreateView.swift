//
//  ContentView.swift
//  PlannerApp
//
//  Created by William Chen on 8/16/26.
//

import SwiftUI
import SwiftData

struct TaskPage: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var navigationPath : NavigationPath
    @State private var userInputName: String = ""
    @State private var userInputDetails: String = ""
    var body: some View {
        VStack {
            Text("Create New Task")
                .font(.title)
            HStack{
                Text("Task Name: ")
                TextField("", text: $userInputName).textFieldStyle(.roundedBorder)
            }.padding()
            HStack{
                VStack{
                    Text("Task Details: ")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("", text: $userInputDetails, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                        .lineLimit(3...)
                }
            }.padding()
            Spacer()
            Button(action: {
                saveTask()
            }) {
                Text("Save Task")
                    .multilineTextAlignment(.center)
                    .frame(width: 100, height: 100)
            }
            .buttonStyle(.borderedProminent)
            .tint(.gray)
        }
    }
    func saveTask(){
        if userInputName != ""{
            var newTask = PlannerTask(name: userInputName, details: userInputDetails)
            modelContext.insert(newTask)
        }
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }
}

#Preview {
    @Previewable @State var navigationPath = NavigationPath()
    TaskPage(navigationPath: $navigationPath)
        .modelContainer(for: [PlannerTask.self, Record.self], inMemory: true)
}
