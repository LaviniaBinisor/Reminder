//
//  NewReminderListView.swift
//  Reminder
//
//  Created by Binisor, Lavinia on 30.08.2023.
//

import SwiftUI

struct NewReminderListView: View {
    @ObservedObject var newMemoList: Reminder
    
    
    var body: some View {
        NavigationStack {
            List {
               Text("New")
            }
        }
    }
}

struct NewReminderListView_Previews: PreviewProvider {
    static var previews: some View {
        NewReminderListView(newMemoList: Reminder.previewReminder)
    }
}
