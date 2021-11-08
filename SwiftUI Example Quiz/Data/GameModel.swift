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
    
    @Published var questionSet: QuestionSet?
    @Published var isLoading = false
    var amountOfQuestions = 5
    private(set) var questionIndex = 0
    
    var nextQuestion: Question? {
        if let questionSet = questionSet, questionSet.results.count > questionIndex {
            return questionSet.results[questionIndex]
        } else {
            return nil
        }
    }
    
    func incrementQuestionIndex() {
        questionIndex += 1
    }
    
    func fetch() {
        if let url = URL(string: "https://opentdb.com/api.php?amount=\(amountOfQuestions)&type=multiple") {
            isLoading = true
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            cancellableTask = URLSession.shared
                .dataTaskPublisher(for: url)
                .tryMap { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    return element.data
                }
                .decode(type: QuestionSet.self, decoder: jsonDecoder)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] _ in
                    self?.isLoading = false
                }, receiveValue: { [weak self] data in
                    self?.questionSet = data
                })
        }
    }
    
}
