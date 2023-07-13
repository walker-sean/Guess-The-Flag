//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Sean Walker on 7/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button {
            print("Editing")
        } label: {
            Label("Edit", systemImage: "pencil")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
