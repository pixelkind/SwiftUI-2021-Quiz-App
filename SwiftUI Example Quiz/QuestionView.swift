//
//  QuestionView.swift
//  SwiftUI Example Quiz
//
//  Created by Garrit Schaap on 2021-11-04.
//

import SwiftUI

struct QuestionView: View {
    let question: Question
    
    var body: some View {
        VStack {
            Text(question.question)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
            GeometryReader { proxy in
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(0..<4) { index in
                        Button {
                            
                        } label: {
                            Text("Answer \(index)")
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
        QuestionView(question: Question(category: "", type: "", difficulty: .easy, question: "", correctAnswer: "", incorrectAnswers: ["", "", ""]))
    }
}
