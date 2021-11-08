//
//  QuestionView.swift
//  SwiftUI Example Quiz
//
//  Created by Garrit Schaap on 2021-11-04.
//

import SwiftUI

struct QuestionView: View {
    let question: Question
    @State var nextQuestion = false
    @ObservedObject var game: GameModel
    
    var body: some View {
        VStack {
            NavigationLink(isActive: $nextQuestion) {
                if let question = game.nextQuestion {
                    QuestionView(question: question, game: game)
                } else {
                    ResultView()
                }
            } label: {
                EmptyView()
            }
            
            Text(question.question)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
            GeometryReader { proxy in
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(question.answers) { answer in
                        Button {
                            print(answer.isCorrect)
                            game.incrementQuestionIndex()
                            nextQuestion = true
                        } label: {
                            Text(answer.text)
                                .frame(height: proxy.size.height / 2)
                                .frame(maxWidth: .infinity)
                        }
                        .background(Color.yellow)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding()
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(question: Question(category: "", type: "", difficulty: .easy, question: "", correctAnswer: "", incorrectAnswers: ["", "", ""]), game: GameModel())
    }
}
