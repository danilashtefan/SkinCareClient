//
//  ErrorView.swift
//  StoryBoardProject
//
//  Created by Danil Stefaniuc on 24.04.2021.
//

import SwiftUI

struct ErrorView: View {
    
    typealias ErrorViewActionHandler = ()->Void
    
    let error: Error
    let handler:ErrorViewActionHandler
    
    internal init(error: Error, handler: @escaping ErrorView.ErrorViewActionHandler){
        self.error = error
        self.handler = handler
    }
    var body: some View {
        VStack{
            Image(systemName: "exclamationmark.icloud.fill")
                .foregroundColor(.gray)
                .font(.system(size: 50, weight: .heavy))
            Text("OOOOPS")
            Text(error.localizedDescription)
            
            Button(action: {
                //WRITE ACTION
                
            }, label: {
                Text("Retry")
            })
        }
        
        
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: APIError.decodingError){}
            .previewLayout(.sizeThatFits)
    }
}
