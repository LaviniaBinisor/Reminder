//
//  HomeViewModel.swift
//  Reminder
//
//  Created by Binisor, Lavinia on 28.08.2023.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var lists: [MemoList]
    
    init(lists: [MemoList]) {
        self.lists = lists
    }
    
    func addNewList(for list: MemoList) {
        lists.append(list)
    }
    
    func duplicate(list: MemoList) {
        let copyList = MemoList(
            name: "\(list.name) - copy",
            iconName: list.iconName,
            iconColor: list.iconColor,
            reminders: list.reminders
        )
        
        if let index = lists.firstIndex(of: list) {
            let nextIndex = index + 1
            lists.insert(copyList, at: nextIndex)
        }
    }
}

