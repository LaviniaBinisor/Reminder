//
//  HomeModel.swift
//  Reminder
//
//  Created by Binisor, Lavinia on 28.08.2023.
//

import SwiftUI

class MemoList: ObservableObject, Identifiable {
    
    let id = UUID()
    @Published var name: String
    @Published var iconName: String
    @Published var iconColor: Color
    @Published var reminders: [Reminder]
    
    var numberOfReminders: Int {
        return reminders.count
    }
    
    init(name: String, iconName: String, iconColor: Color, reminders: [Reminder] = []) {
        self.name = name
        self.iconName = iconName
        self.iconColor = iconColor
        self.reminders = reminders
    }
}

class Reminder: ObservableObject, Identifiable {
    let id = UUID()
    @Published var name: String
    @Published var details: String
    @Published var isCompleted: Bool
    
    var isEmpty: Bool {
        name.isEmpty && details.isEmpty
    }
    
    init(name: String = "", details: String = "", isCompleted: Bool = false) {
        self.name = name
        self.details = details
        self.isCompleted = isCompleted
    }
}

// MARK: Conform with Hashable and Equatable
extension Reminder: Hashable, Equatable {
    static func == (lhs: Reminder, rhs: Reminder) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.details == rhs.details &&
        lhs.isCompleted == rhs.isCompleted
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: Conform with Hashable and Equatable
extension MemoList: Hashable, Equatable {
    static func == (lhs: MemoList, rhs: MemoList) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.iconName == rhs.iconName &&
        lhs.iconColor == rhs.iconColor &&
        lhs.reminders == rhs.reminders
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}



// MARK: For Preview purposes
extension MemoList {
    static let previewList = MemoList(name: "Mountain climb", iconName: "mountain.2", iconColor: .blue, reminders: Reminder.previewReminders)
    
    static let previewLists: [MemoList] = [
        MemoList(name: "Shopping", iconName: "cart", iconColor: .blue, reminders: Reminder.previewReminders),
        MemoList(name: "Reading", iconName: "bookmark", iconColor: .purple, reminders: Reminder.previewReminders),
        MemoList(name: "To home", iconName: "list.bullet.circle", iconColor: .yellow, reminders: Reminder.previewReminders)
    ]
}


extension Reminder {
    static let previewReminder = Reminder(name: "Mountain climb", details: "VF.Moldoveanu")
    
    static let previewReminders = [
        Reminder(name: "Cooking", details: "Pasta", isCompleted: false),
        Reminder(name: "Coding", details: "Xcode", isCompleted: true),
        Reminder(name: "Reading", details: "CodeWithCriss", isCompleted: true)
    ]
}
