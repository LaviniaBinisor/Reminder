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
}

