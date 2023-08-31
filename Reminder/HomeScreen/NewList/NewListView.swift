//
//  NewListView.swift
//  Reminder
//
//  Created by Binisor, Lavinia on 28.08.2023.
//

import SwiftUI

struct NewListView: View {
    private let availableColors: [Color] = [
        .red, .orange, .yellow, .green, .blue, .cyan, .pink, .black, .brown, .indigo
    ]
    
    private let availableSymbols: [String] = [
        "pencil", "book", "figure.run", "figure.indoor.cycle",
        "cart", "cart.fill", "house", "mountain.2", "laptopcomputer",
        "airplane.circle.fill", "alarm", "list.bullet.circle"
    ]
    
    var listViewModel: HomeViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var listName = ""
    @State private var selectedColor = Color.cyan
    @State private var selectedSymbol = "list.bullet.circle"
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Image(systemName: selectedSymbol)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(20)
                        .background(selectedColor)
                        .clipShape(Circle())
                        .frame(maxWidth: .infinity)
                    
                    TextField("List name", text: $listName)
                }
                
                Section {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(availableColors, id: \.self) { color in
                                Button {
                                    selectedColor = color
                                } label: {
                                    Circle()
                                        .frame(width: 40)
                                        .foregroundColor(color)
                                }
                            }
                        }
                    }
                } header: {
                    Text("Colors")
                } footer: {
                    Text("Pick your favorite color from the list.")
                }
                
                Section {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(availableSymbols, id: \.self) { symbol in
                                Button {
                                    selectedSymbol = symbol
                                } label: {
                                    ZStack {
                                        Circle()
                                            .frame(width: 40)
                                            .foregroundColor(.secondary)
                                        Image(systemName: symbol)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                    }
                } header: {
                    Text("Symbols")
                } footer: {
                    Text("Pick your symbol.")
                }
            }
            .navigationTitle("New List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button ("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Create") {
                        createNewList()
                        dismiss()
                    }
                    .disabled(listName.isEmpty)
                }
            }
        }
    }
}

private extension NewListView {
    func createNewList() {
        let newList = MemoList(name: listName, iconName: selectedSymbol, iconColor: selectedColor)
        listViewModel.addNewList(for: newList)
    }
}

struct NewListView_Previews: PreviewProvider {
    static var previews: some View {
        NewListView(listViewModel: HomeViewModel(lists: MemoList.previewLists))
    }
}
