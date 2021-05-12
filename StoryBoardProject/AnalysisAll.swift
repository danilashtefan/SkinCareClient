//
//  AnalysisAll.swift
//  StoryBoardProject
//
//  Created by Daniela Andreea Moraru on 2021. 05. 12..
//

import SwiftUI

struct AnalysisAll: View {
    var body: some View {
        NavigationView{
            AnalysisList(list_size: 5)
            
        }
    }
}
            
    




struct AnalysisAll_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisAll()
    }
}
