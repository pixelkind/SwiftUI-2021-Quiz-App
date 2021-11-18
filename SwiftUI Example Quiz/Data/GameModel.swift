//
//  GameModel.swift
//  SwiftUI Example Quiz
//
//  Created by Garrit Schaap on 2021-11-04.
//

import Foundation
import Combine

class GameModel: ObservableObject {
    
    private var cancellableTask: AnyCancellable?
    private var anyCancellable: AnyCancellable?
    
    @Published var questionSet: QuestionSet?
    @Published var isLoading = false
    
    let remote: Remote<QuestionSet>
    var amountOfQuestions = 5
    private(set) var questionIndex = 0
    
    var nextQuestion: Question? {
        if let questionSet = remote.data, questionSet.results.count > questionIndex {
            return questionSet.results[questionIndex]
        } else {
            return nil
        }
    }
    
    init() {
        remote = Remote(url: URL(string: "https://opentdb.com/api.php?amount=5&type=multiple")!)
        anyCancellable = remote.objectWillChange.sink(receiveValue: { [weak self] in
            self?.objectWillChange.send()
        })
    }
    
    func incrementQuestionIndex() {
        questionIndex += 1
    }
    
}
