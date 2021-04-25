//
//  NewsViewModel.swift
//  StoryBoardProject
//
//  Created by Danil Stefaniuc on 24.04.2021.
//

import Foundation
import Combine


protocol NewsViewModel {
    func getArticles()
}

class NewsViewModelImpl: ObservableObject, NewsViewModel{
    
    private let service: NewsService
    private(set) var articles = [Article]()
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var state: ResultState = .loading
    
    init(service: NewsService){
        self.service=service
    }
    func getArticles() {
        let cancellable = service
            .request(from: .getNews)
            .sink { res in
                switch res{
                
                case .finished:
                    print("Articles are: \(self.articles[0].author)")
                    self.state = .success(content: self.articles)
                    
                case .failure(let error):
                    self.state = .failed(error: error)
                }
            } receiveValue: { response in
                self.articles = response.articles
                
            }
        self.cancellables.insert(cancellable)
    }
}
