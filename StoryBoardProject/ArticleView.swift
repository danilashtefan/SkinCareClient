//
//  ArticleView.swift
//  StoryBoardProject
//
//  Created by Danil Stefaniuc on 24.04.2021.
//

import SwiftUI
import URLImage

struct ArticleView: View {
    let article: Article
    
    var body: some View {
        HStack{
            if let imgUrl = article.urlToImage,
               let url = URL(string: imgUrl){
                URLImage(url: url,
                         options: URLImageOptions(
                            identifier: article.id.uuidString,
                            cachePolicy:
                                .returnCacheElseLoad(cacheDelay: nil, downloadDelay: 0.25)
                         ),
                         failure:{
                            error, _ in
                            Image(systemName: "photo.fill")
                                .foregroundColor(.white)
                                .background(Color.gray)
                                .frame(width:100, height: 100)
                            
                            
                            
                         },
                         content: { image in
                            image
                            .resizable()
                                .aspectRatio(contentMode: .fill)
                            
                         })
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
            else{
                Image(systemName: "photo.fill")
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .frame(width:100, height: 100)
            }
            
            VStack(alignment: .leading, spacing: 4){
                Text(article.title ?? "")
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .semibold))
                Text(article.source.name ?? "N/A")
                    .foregroundColor(.gray)
                    .font(.footnote)
            }
        }
    }
}


struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: Article.dummyData)
    }
}
