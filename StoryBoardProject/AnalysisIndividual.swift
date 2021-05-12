//
//  AnalysisIndividual.swift
//  StoryBoardProject
//
//  Created by Daniela Andreea Moraru on 2021. 05. 06..
//

import SwiftUI

struct AnalysisIndividual: View {
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    NavigationLink(
                        destination: Text("Destination")){
                        Image("chevron-left")
                            .frame(width: 20.0, height: 20.0)
                    }
                    .frame(width: 50.0, height: 50.0)
////
//
//                    //                TODO align more right
////                                    Text("Redness")
////                                        .foregroundColor(Color(#colorLiteral(red: 0.1570588052, green: 0.6564927101, blue: 0.8748285174, alpha: 1)))
////                                        .font(.callout)
////                                        .alignmentGuide(.leading, computeValue: { dimension in
////                                            dimension[.trailing]
////                                        }).padding(.leading, 100)
////                                }.position(CGPoint(x: 55.0, y: 10.0))
////                                .frame(width: 200, height: 50, alignment: .top)
//

                }.frame(width: 300, height: 100 , alignment: .top)
                
                
            
                
                
                ScrollView(.horizontal){
                    HStack{
                        Image("analysis-image")
                            .resizable()
                            .frame(width: 299, height: 370, alignment: .center)
                        Image("analysis-image")
                            .resizable()
                            .frame(width: 299, height: 370, alignment: .center)
                    }
                }
                
                
                //            TODO change font to a custom one
                Text("Skin analysis 5")
                    .frame(width: 327, height: 20, alignment: .leading)
                    .font(Font.system(size:30, design: .default))
                
                Text("100 skin points")
                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0.6945464015, blue: 0.3402124643, alpha: 1)))
                    .font(Font.system(size:15,  weight: .bold, design: .rounded))
                    .frame(width: 327, height: 20, alignment: .leading)
                    .padding(.top, 5)
                    .padding(.bottom, 10)
                
                Text("Your skin  have acne and rosacea. Rosacea is not caused by poor hygene. Please refer to the risk factors below: \nHot drinks and spicy foods\nRed wine and other ages\nTemperature extremes\nSunlight")
                    .foregroundColor(Color(#colorLiteral(red: 0.4548544884, green: 0.4549351335, blue: 0.4548438787, alpha: 1)))
                    .frame(width: 327, height: 154, alignment: .center)
                
                ZStack{
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 0.9450049996, green: 0.9451631904, blue: 0.9449841976, alpha: 1)))
                        .frame(width: 327, height: 54)
                        .cornerRadius(8)
                    
                    Text("Leave a note for yourself")
                        .foregroundColor(Color(#colorLiteral(red: 0.4548544884, green: 0.4549351335, blue: 0.4548438787, alpha: 1)))
                        .font(Font.system(size:14,  weight: .light, design: .rounded))
                        .frame(width: 327, height: 20, alignment: .leading)
                        .padding(.leading, 10)
                }
            }
        }
    }
}

struct AnalysisIndividual_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisIndividual()
    }
}
