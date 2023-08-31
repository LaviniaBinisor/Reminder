//
//  ReminderListView.swift
//  Reminder
//
//  Created by Binisor, Lavinia on 30.08.2023.
//

import SwiftUI

struct ReminderListView: View {
    @ObservedObject var memoList: MemoList
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(memoList.reminders) { reminder in 
                    ReminderRow(reminder: reminder)
                }
                .onDelete { index in
                    memoList.reminders.remove(atOffsets: index)
                }
            }
            .navigationTitle(memoList.name)
            .toolbar {
                Button {
                    addNewReminder()
                } label: {
                    Image(systemName: "plus.circle")
                }
                
            }
        }
    }
    
    func addNewReminder() {
        if let lastReminder = memoList.reminders.last {
            if lastReminder.isEmpty == false {
                memoList.reminders.append(Reminder())
            }
        } else {
            memoList.reminders.append(Reminder())
        }
    }
}

private struct ReminderRow: View {
    @ObservedObject var reminder: Reminder
    @FocusState var isNameFocused: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Button {
                reminder.isCompleted.toggle()
            } label: {
                Image(systemName: reminder.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .fontWeight(.light)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                TextField("Remainder", text: $reminder.name)
                    .focused($isNameFocused)
                    .font(.headline)
                TextField("Add a note", text: $reminder.details)
                    .foregroundColor(.secondary)
            }
        }
        .onAppear {
            isNameFocused = reminder.isEmpty
        }
    }
}

struct ReminderListView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderListView(memoList: MemoList.previewList)
    }
}

