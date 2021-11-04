//
//  ContentView.swift
//  SwiftUI Example Quiz
//
//  Created by Garrit Schaap on 2021-11-04.
//

import SwiftUI

struct ContentView: View {
    @State private var startGame = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(isActive: $startGame) {
                    QuestionView()
                } label: {
                    EmptyView()
                }

                
                Button {
                    startGame.toggle()
                } label: {
                    Text("Start Game")
                }
            }
            .navigationTitle("Quiz")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
