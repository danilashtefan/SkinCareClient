//
//  NewsView.swift
//  StoryBoardProject
//
//  Created by Danil Stefaniuc on 24.04.2021.
//

import SwiftUI

struct NewsView: View {
    @Environment(\.openURL) var openUrl
    @StateObject var viewModel = NewsViewModelImpl(service: NewsServiceImpl())
    var body: some View {
        Group{
            
            switch viewModel.state{
            case .loading:
                ProgressView()
                    .padding(325)
            case .failed(let error):
                ErrorView(error: error, handler: viewModel.getArticles)
            case .success(let articles):
                NavigationView{
                    List(articles){ item in
                        ArticleView(article: item)
                            .onTapGesture {
                                load(url: item.url)
                            }
                        
                    }
                    .navigationTitle(Text("Beauty Articles"))
                }
            }
            
        }.onAppear(perform: viewModel.getArticles)
    }
    
    func load(url: String?) {
        guard let link = url,
              let url = URL(string: link) else {return}
        
        openUrl(url)
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
