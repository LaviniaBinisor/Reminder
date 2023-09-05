//
//  NewListView.swift
//  Reminder
//
//  Created by Binisor, Lavinia on 28.08.2023.
//

import SwiftUI

struct NewListView: View {
    
    var listViewModel: HomeViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var listName = ""
    @State private var selectedColor = Color.cyan
    @State private var selectedSymbol = "list.bullet.circle"
    
    var body: some View {
        NavigationStack {
            Form {
                sectionTitle
                
                colorSection
                
                symbolsSection
                
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

//MARK: View components

private extension NewListView {
    var sectionTitle: some View {
        Section {
            Circle()
                .foregroundColor(selectedColor)
                .frame(width: 100)
                .overlay {
                    Image(systemName: selectedSymbol)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .scaleEffect(1.3)
                }
                .frame(maxWidth: .infinity)

            TextField("List name", text: $listName)
        }
    }
    
    var colorSection: some View {
        let availableColors: [Color] = [
            .orange, .yellow, .red, .mint, .green, .cyan, .blue, .indigo, .purple, .brown, .black, .gray
        ]
        
        let columns = [
            GridItem(.adaptive(minimum: 40))
        ]
        
        return Section {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(availableColors, id: \.self) { color in
                        Button {
                            selectedColor = color
                        } label: {
                            Circle()
                                .foregroundColor(color)
                                .padding(5)
                                .overlay {
                                    Circle()
                                        .stroke(selectedColor == color ? Color.secondary.opacity(0.7) : .clear,
                                                lineWidth: 3)
                                }
                            
                        }
                    }
                }
                .padding([.top, .horizontal], 6)
            }
        } header: {
            Text("Colors")
        } footer: {
            Text("Pick your favorite color from the list.")
        }
    }
    
    var symbolsSection: some View {
        let availableSymbols: [String] = [
            "pencil", "book", "figure.run", "figure.indoor.cycle",
            "cart", "cart.fill", "house", "mountain.2", "laptopcomputer",
            "airplane.circle.fill", "alarm", "list.bullet.circle",
        ]
        
        let columns = [
            GridItem(.adaptive(minimum: 35))
        ]
        
        return Section {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(availableSymbols, id: \.self) { symbol in
                        Button {
                            selectedSymbol = symbol
                        } label: {
                            ZStack {
                                Circle()
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
}

// MARK: Will be moved in the View Model
private extension NewListView {
#warning("Move this into the view model")
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
