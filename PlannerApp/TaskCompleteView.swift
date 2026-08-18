//
//  ContentView.swift
//  PlannerApp
//
//  Created by William Chen on 8/16/26.
//

import SwiftUI

struct TaskCompletePage: View {
    @Binding var navigationPath : NavigationPath
    var task:PlannerTask
    var body: some View {
        VStack {
            Text("Task Details")
                .font(.title)
            HStack{
                Text("Task Name: "+task.name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }.padding()
            HStack{
                VStack{
                    Text("Task Details: ")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(task.details)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
            }.padding()
            Spacer()
            Button(action: {
                completeTask()
            }) {
                Text("Complete Task")
                    .multilineTextAlignment(.center)
                    .frame(width: 100, height: 100)
            }
            .buttonStyle(.borderedProminent)
            .tint(.gray)
        }
    }
    func completeTask(){
        task.isCompleted = true
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }
}

#Preview {
    @Previewable @State var navigationPath = NavigationPath()
    @Previewable var task:PlannerTask = PlannerTask(name: "example", details: "example")
    TaskCompletePage(navigationPath: $navigationPath, task: task)
}
