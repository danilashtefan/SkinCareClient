//
//  AnalysisAll.swift
//  StoryBoardProject
//
//  Created by Daniela Andreea Moraru on 2021. 05. 12..
//

import SwiftUI

struct AnalysisAll: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
            Image("chevron-left") // set image here
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                Text("Go back")
            }
        }
    }
    
    var body: some View {
        VStack{
            NavigationView{
                NavigationLink(
                    destination: ContentView()){
                    
                        Image("chevron-left") // set image here
                        .aspectRatio(contentMode: .fit)
                       .foregroundColor(.white)
                        .frame(width: 300, height: 20, alignment: .leading)
                }
                
                AnalysisList(list_size: 5)
                
            }
            
        }
    }

}

struct AnalysisAll_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisAll()
    }
}
