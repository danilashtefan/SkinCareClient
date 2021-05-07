//
//  ShowMoreButton.swift
//  StoryBoardProject
//
//  Created by Daniela Andreea Moraru on 2021. 04. 25..
//

import SwiftUI

struct BlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color(#colorLiteral(red: 0.1676534116, green: 0.6564235687, blue: 0.8748063445, alpha: 1)) : Color(#colorLiteral(red: 0.99598068, green: 0.9961469769, blue: 0.9959587455, alpha: 1)))
            .background(configuration.isPressed ? Color(#colorLiteral(red: 0.99598068, green: 0.9961469769, blue: 0.9959587455, alpha: 1)) :  Color(#colorLiteral(red: 0.1676534116, green: 0.6564235687, blue: 0.8748063445, alpha: 1)))
            .cornerRadius(25)
            .shadow(color: .gray, radius:5 , x:2 ,y: 1)
            
    }
}

struct ShowMoreButton: View {
    var body: some View {
        VStack {
            Button(action: { }) {
                Text("   Click for more   ")
                    .frame(maxWidth: 140, maxHeight: 24)
            }
            .buttonStyle(BlueButtonStyle())
        }
    }
}

struct ShowMoreButton_Previews: PreviewProvider {
    static var previews: some View {
        ShowMoreButton()
    }
}
