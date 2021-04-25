//
//  NewsEndpoint.swift
//  StoryBoardProject
//
//  Created by Danil Stefaniuc on 24.04.2021.
//

import Foundation

protocol APIBuilder{
    var urlRequest: URLRequest{get}
    var baseUrl: URL {get}

}


enum NewsAPI{
    case getNews
}

extension NewsAPI: APIBuilder{
 
    
var urlRequest: URLRequest {
    print(self.baseUrl)
    return URLRequest(url: self.baseUrl)
}


    var baseUrl: URL {
        switch self {
        case .getNews:
            return URL(string: "https://newsapi.org/v2/everything?q=skincare&apikey=\(APIKey.key)")!
        }
    }

}

    

