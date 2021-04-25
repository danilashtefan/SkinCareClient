//
//  ResultState.swift
//  StoryBoardProject
//
//  Created by Danil Stefaniuc on 24.04.2021.
//

import Foundation

enum ResultState{
    case loading
    case success(content: [Article])
    case failed(error: Error)
}
