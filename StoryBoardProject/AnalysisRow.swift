//
//  AnalysisRow.swift
//  StoryBoardProject
//
//  Created by Daniela Andreea Moraru on 2021. 04. 25..
//

import SwiftUI

struct AnalysisRow: View {
    
    var image_name: String;
    
    var body: some View {
        ZStack{
            Image("Rectangle")
            HStack{
                Image(image_name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 310, height: 62, alignment: .topLeading)
            }.frame(width: 310, height: 120, alignment: .center)
            VStack{
                NavigationLink(
                    destination: AnalysisIndividual()){
                    
                    Text("Skin analysis 5")
                        .alignmentGuide(.top, computeValue: { dimension in
                        dimension[.top]
                    })
                        .foregroundColor(Color.black)
                        .font(Font.headline.weight(.bold))
                }

                HStack{
                    ZStack{
                        Rectangle()
                            .fill(Color(#colorLiteral(red: 1, green: 0.9593283534, blue: 0.9253948331, alpha: 1)))
                            .frame(width: 70, height: 20)
                            .cornerRadius(25)
                            .shadow(color: .gray, radius:2 , x:1 ,y: 1)
                        Text("Redness")
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 0.5790656805, blue: 0.1987296045, alpha: 1)))
                            .font(.footnote)
                        
                    }
                    ZStack{
                        Rectangle()
                            .fill(Color(#colorLiteral(red: 0.9074700475, green: 0.9626085162, blue: 0.9872609973, alpha: 1)))
                            .frame(width: 70, height: 20)
                            .cornerRadius(25)
                            .shadow(color: .gray, radius:2 , x:1 ,y: 1)
                        Text("Redness")
                            .foregroundColor(Color(#colorLiteral(red: 0, green: 0.622490108, blue: 0.8814242482, alpha: 1)))
                            .font(.footnote)
                    }
                }
                ZStack{
                    HStack{
                        Image("Vector").alignmentGuide(.leading, computeValue: { dimension in
                            dimension[.leading]
                        })
                        Text("Budapest")
                        .foregroundColor(Color(#colorLiteral(red: 0.4548544884, green: 0.4549351335, blue: 0.4548438787, alpha: 1)))
                    }.frame(width: 130, height: 30, alignment: .leading)
                    Text("100 skin points")
                        .foregroundColor(Color(#colorLiteral(red: 0, green: 0.6945464015, blue: 0.3402124643, alpha: 1)))
                        .font(Font.system(size:15,  weight: .bold, design: .rounded))
                        .frame(width: 300, height: 30, alignment: .trailing)
                }

                    

                    
            }.frame(width: 300, height: 100, alignment: .top)

            
            
            
        }
//        .background(Color(red: 229, green: 229, blue: 229))
        
    }
}

struct AnalysisRow_Previews: PreviewProvider {
    static var previews: some View {
        var image_name = "analysis-image"
        AnalysisRow(image_name: image_name)
    }
}
