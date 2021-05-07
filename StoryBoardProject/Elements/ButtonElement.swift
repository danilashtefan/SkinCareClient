//
//  ButtonElement.swift
//  StoryBoardProject
//
//  Created by Daniela Andreea Moraru on 2021. 04. 25..
//

import SwiftUI

struct ButtonElement: View {
    @State var isNavigate :Bool = false
    var body: some View {
        NavigationView{
                    VStack{
                        NavigationLink(destination: SwiftUIView()) {
                            Image("btn")
                        }
                    }
        }.frame(width: 200, height: 150, alignment: .top)
    }
}

struct ButtonElement_Previews: PreviewProvider {
    static var previews: some View {
        ButtonElement()
    }
}
