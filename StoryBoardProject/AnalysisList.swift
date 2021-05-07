//
//  AnalysisList.swift
//  StoryBoardProject
//
//  Created by Daniela Andreea Moraru on 2021. 04. 25..
//

import SwiftUI

struct AnalysisList: View {
    var body: some View {
        VStack{
            AnalysisRow()
            AnalysisRow()
        }
    }
}

struct AnalysisList_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisList()
    }
}
