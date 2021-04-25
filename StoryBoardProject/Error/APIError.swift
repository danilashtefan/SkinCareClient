//
//  APIError.swift
//  StoryBoardProject
//
//  Created by Danil Stefaniuc on 24.04.2021.
//

import Foundation

enum APIError:Error{
    case decodingError
    case errorCode(Int)
    case unknown
}

extension APIError: LocalizedError{
    var errorDescription: String?{
        switch self {
        case .decodingError:
            return "Failed to decode"
        case .errorCode(let code):
            return "Something went wrong"
        case.unknown:
            return "Unknown error" 
        }
    }
    
    
    
    
}
