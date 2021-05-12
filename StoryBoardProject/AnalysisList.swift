//
//  AnalysisList.swift
//  StoryBoardProject
//
//  Created by Daniela Andreea Moraru on 2021. 04. 25..
//

import SwiftUI

struct AnalysisList: View {
    var list_size: Int
    var body: some View {
        VStack{
            let image_name_string = "analysis-image"
            
            ForEach(0..<list_size){_ in
                AnalysisRow(image_name: image_name_string)
        }
            
           
        }
    }
}

struct AnalysisList_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisList(list_size: 2)
    }
}
