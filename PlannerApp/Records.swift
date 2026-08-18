//
//  Records.swift
//  PlannerApp
//
//  Created by William Chen on 8/16/26.
//
import SwiftUI
import SwiftData

struct RecordsView:View {
    @Environment(\.modelContext) private var modelContext
    @Binding var navigationPath: NavigationPath
    @Query var recordList: [Record]
    var body: some View {
        VStack{
            Text("Records")
                .font(.title)
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(recordList) { record in
                        RecordWidget(navigationPath: $navigationPath, record: record)
                    }
                }
                .padding(.horizontal)
            }
            
            Spacer()
        }
    }
}

struct RecordWidget: View {
    @Binding var navigationPath: NavigationPath
    var record: Record
    var body: some View {
        HStack{
            Button(action: {
                print("Tapped ID: \(record.id)")
                navigateToRecord(record: record)
            }) {
                HStack{
                    Text("Record - "+record.date)
                    Spacer()
                }.padding()
            }
            .buttonStyle(.borderedProminent)
            .tint(.gray)
        }
    }
    func navigateToRecord(record:Record) {
        print("Function called! Performing actions before moving to record - "+record.date)
        navigationPath.append(record)
    }
}

#Preview{
    @Previewable @State var navigationPath = NavigationPath()
    RecordsView(navigationPath: $navigationPath).modelContainer(for:[Record.self, PlannerTask.self], inMemory: true)
}
