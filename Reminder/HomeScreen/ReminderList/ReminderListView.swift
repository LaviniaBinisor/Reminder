//
//  ReminderListView.swift
//  Reminder
//
//  Created by Binisor, Lavinia on 30.08.2023.
//

import SwiftUI

struct ReminderListView: View {
    @ObservedObject var memoList: MemoList
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(reminderResults) { reminder in
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
            .searchable(text: $searchText)
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
    
    var reminderResults: [Reminder] {
        if searchText.isEmpty {
            return memoList.reminders
        } else {
            return memoList.reminders.filter { reminder in
                reminder.name.contains(searchText) || reminder.details.contains(searchText)
            }
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

