//
//  SwiftUIView.swift
//  StoryBoardProject
//
//  Created by Danil Stefaniuc on 09.04.2021.
//

import SwiftUI
import URLImage

struct SwiftUIView: View {
    
    init(){
        UITabBar.appearance().barTintColor = .systemBackground
    }
    

    var body: some View {
        TabView{
                ZStack {
                    Color(#colorLiteral(red: 0.9682741117, green: 0.9682741117, blue: 0.9682741117, alpha: 1)).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    VStack (){
        
                        Header()
                        Search()
                            .padding(.top, 10)
                        //Cards()
                            .padding(.top, 30)
        
                        //Photos()
                    }
                }
                .tabItem {
                    Image(systemName: "house")
                                .font(.system(size: 26))
                                .foregroundColor(.white)
                       
                }
                .tabItem {
                    
                            Image(systemName: "heart")
                                .font(.system(size: 26))
                                .foregroundColor(.white)
                        
                        
                    }
                .tabItem {
                    
                            Image(systemName: "cube")
                                .font(.system(size: 26))
                                .foregroundColor(.white)
                      
                }
                
                    .tabItem {
                       
                                Image(systemName: "person")
                                    .font(.system(size: 26))
                                    .foregroundColor(.white)
                           
                    }
                }
                
            
                
        }
    }


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}



//MARK: Header
struct Header: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("SkincareApp")
                    .font(.system(size: 19, weight: .medium, design: .serif))
                    .foregroundColor(Color(#colorLiteral(red: 0.9762545228, green: 0.6769368052, blue: 0.6951140761, alpha: 1)))
                
            }
            .padding(.leading, 10)
            Spacer()
            
        }
    }
}

struct Photo:View {
    var body: some View{
 
        VStack {
            Image("Geometry")
                .resizable()
                .aspectRatio(contentMode: .fill)
           
        }
        .frame(width: 370, height: 90)
        .background(Color.white)
        .cornerRadius(30)
        .onTapGesture {
            print("History tab was tapped")
        }
    }
}

/*struct Photos:View {
    
    var body: some View {
    
    }

}*/

//MARK: Search
struct Search: View {
    var body: some View {
        HStack {
            Text("Search for 3D products")
                .foregroundColor(.gray)
                .font(.system(size: 15))
                .padding(.leading, 20)
            Spacer()
            Image(systemName: "magnifyingglass")
                .font(.system(size: 26, weight: .medium, design: .serif))
                .foregroundColor(Color(#colorLiteral(red: 0.9762545228, green: 0.6769368052, blue: 0.6951140761, alpha: 1)))
                .padding(.trailing, 20)
            
        }
        .frame(width: 350, height: 54)
        .background(Color.white)
        .cornerRadius(14)
    }
}


struct Card:View {
    var body: some View{
        VStack {
            Image("analysis-image")
                .resizable()
                .aspectRatio(contentMode: .fill)
           
        }
        .frame(width: 140, height: 140)
        .background(Color.white)
        .cornerRadius(30)
        .onTapGesture {
            print("Card was tapped")
        }
       
    }
}


//MARK: Tabbar
struct Tabbar: View {
    var body: some View {
        HStack (spacing: 30) {
            VStack {
                Button(action: {
                    
                    //add action here
                    
                    
                }, label: {
                    Image(systemName: "house")
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                })
               
               
            }
            VStack {
                
                Button(action: {
                    
                    Circle().opacity(1)
                    
                    
                }, label: {
                    Image(systemName: "heart")
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                })
             
                Circle()
                    .frame(width: 6, height: 6)
                    .foregroundColor(.white)
                    .opacity(0)
            }
            VStack {
                
                Button(action: {
                    
                    
                    //add action here
                    
                    
                }, label: {
                    Image(systemName: "cube")
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                })
               
                Circle()
                    .frame(width: 6, height: 6)
                    .foregroundColor(.white)
                    .opacity(0)
            }
            VStack {
                
                Button(action: {
                    //add action here
                    
                    
                }, label: {
                    Image(systemName: "person")
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                })
               
                Circle()
                    .frame(width: 6, height: 6)
                    .foregroundColor(.white)
                    .opacity(0)
            }
        }
        .frame(height: 84)
        .frame(maxWidth: .infinity)
        .background(Color(#colorLiteral(red: 0.9762545228, green: 0.6769368052, blue: 0.6951140761, alpha: 1)))
        .cornerRadius(90)
        
    }
    
    
    
    
    
    
    
   
    
}
