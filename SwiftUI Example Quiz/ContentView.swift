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
                        if let question = game.nextQuestion {
                            QuestionView(question: question, game: game)
                        }
                    } label: {
                        EmptyView()
                    }

                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                    
                    Button {
                        game.remote.fetch()
//                        game.fetch()
    //                    startGame.toggle()
                    } label: {
                        Text("Start Game")
                    }
                }
                
                if game.remote.isLoading {
                    Color.white
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    ProgressView()
                }
            }
            .onChange(of: game.remote.isLoading, perform: { newValue in
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
