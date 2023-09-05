//
//  HomeView.swift
//  Reminder
//
//  Created by Binisor, Lavinia on 28.08.2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    @State private var isNewListViewPresented = false
    
    @State private var presentEditNameAlert = false
    @State private var selectedList = MemoList.previewList
    @State private var selectedListName = MemoList.previewList.name
    
    
    init(lists: [MemoList]) {
        let listViewModel = HomeViewModel(lists: lists)
        _viewModel = StateObject(wrappedValue: listViewModel)
    }
    
    var body: some View {
        NavigationStack {
            List($viewModel.lists, editActions: .delete) { $list in
                NavigationLink {
                    ReminderListView(memoList: list)
                } label: {
                    MemoListRow(list: list)
                }
                .contextMenu {
                    Button {
                        withAnimation {
                            viewModel.duplicate(list: list)
                        }
                    } label: {
                        Label("Duplicate", systemImage: "doc.on.doc")
                    }
                    
                    Button {
                        selectedList = list
                        selectedListName = list.name
                        presentEditNameAlert = true
                    } label: {
                        Label("Rename", systemImage:"rectangle.and.pencil.and.ellipsis")
                    }
                }
            }
            .alert("Rename", isPresented: $presentEditNameAlert) {
                TextField("Title", text: $selectedListName)
                
                Button("Cancel", role: .cancel) {
                }
                
                Button("Save") {
                    selectedList.name = selectedListName
                }
            }
            
            .navigationTitle("Remainders")
            .toolbar {
                showNewListButton
                EditButton()
            }
        }
    }
    
    var showNewListButton: some View {
        Button {
            isNewListViewPresented = true
        } label: {
            Image(systemName: "plus.circle")
        }
        .sheet(isPresented: $isNewListViewPresented) {
            NewListView(listViewModel: viewModel)
        }
    }
}

private extension HomeView {
    struct MemoListRow: View {
        @ObservedObject var list: MemoList
        
        var body: some View {
            HStack {
                Label {
                    Text(list.name)
                } icon: {
                    Image(systemName: list.iconName)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(list.iconColor)
                        .clipShape(Circle())
                }
                .padding(.vertical, 2)
                
                Spacer()
                
                Text("\(list.numberOfReminders)")
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView(lists: MemoList.previewLists)
                .preferredColorScheme(.light)
            
            HomeView(lists: MemoList.previewLists)
                .preferredColorScheme(.dark)
            
        }
    }
}
