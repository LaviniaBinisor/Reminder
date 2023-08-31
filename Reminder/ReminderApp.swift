//
//  ReminderApp.swift
//  Reminder
//
//  Created by Binisor, Lavinia on 28.08.2023.
//

import SwiftUI

@main
struct ReminderApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(lists: MemoList.previewLists)
        }
    }
}
