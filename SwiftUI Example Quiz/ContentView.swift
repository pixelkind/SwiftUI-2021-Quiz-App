//
//  ContentView.swift
//  SwiftUI Example Quiz
//
//  Created by Garrit Schaap on 2021-11-04.
//

import SwiftUI

struct ContentView: View {
    @StateObject var game = GameModel()
    @State private var startGame = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    NavigationLink(isActive: $startGame) {
                        QuestionView(question: game.nextQuestion)
                    } label: {
                        EmptyView()
                    }

                    
                    Button {
                        game.fetch()
    //                    startGame.toggle()
                    } label: {
                        Text("Start Game")
                    }
                }
                
                if game.isLoading {
                    Color.white
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    ProgressView()
                }
            }
            .onChange(of: game.isLoading, perform: { newValue in
                if newValue == false {
                    startGame.toggle()
                }
            })
            .navigationTitle("Quiz")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
