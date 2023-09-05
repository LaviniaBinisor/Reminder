//
//  TestView.swift
//  Reminder
//
//  Created by ionut.binisor on 05.09.2023.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .padding(3)
            .overlay {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(.blue, lineWidth: 3)
            }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
