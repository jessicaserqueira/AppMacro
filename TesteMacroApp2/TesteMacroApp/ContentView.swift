//
//  ContentView.swift
//  TesteMacroApp
//
//  Created by Jéssica on 28/12/23.
//

import SwiftUI
import Testemacro

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            #stringify({
                print(123)
            }, {
                print(90)
            }, {
                print(85)
            })
        }
    }
}

#Preview {
    ContentView()
}
