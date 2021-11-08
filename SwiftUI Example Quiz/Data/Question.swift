//
//  Question.swift
//  SwiftUI Example Quiz
//
//  Created by Garrit Schaap on 2021-11-04.
//

import Foundation
import SwiftUI

struct Question: Decodable {
    
    struct Answer: Identifiable {
        let id = UUID().uuidString
        let text: String
        let isCorrect: Bool
    }
    
    enum Difficulty: String, Decodable {
        case easy, medium, hard
    }
    
    let category: String
    let type: String
    let difficulty: Difficulty
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    
    var answers: [Answer] {
        var answers = incorrectAnswers.map { Answer(text: $0, isCorrect: false) }
        answers.append(Answer(text: correctAnswer, isCorrect: true))
        return answers.shuffled()
    }
    
}
