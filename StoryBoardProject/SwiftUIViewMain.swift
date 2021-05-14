//
//  ContentView.swift
//  CustomTabBarLBTA
//
//  Created by Brian Voong on 1/7/21.
//

import UIKit
import FirebaseStorage
import Firebase
import ProgressHUD
import SwiftUI
import UIKit


class NumberOfCards:ObservableObject{
    @Published var numOfCards = 1 //We will need to load all articles to the Array and change this according to the nuber of articles
}

class NumberOfPhotos:ObservableObject{
    @Published var numOfPhotos = 5 //Same as in previous
}

struct ContentView: View {
    private let storage = Storage.storage().reference()
    @State private var image = UIImage()
    @State private var showingImagePicker = false
   
   
    
    
    
    @State var selectedIndex = 0
    @State var shouldShowModal = false
    @StateObject var selfNumOfCards = NumberOfCards()
    @StateObject var selfNumOfPhotos = NumberOfPhotos()
    
    let tabBarImageNames = ["house", "heart", "plus.app.fill", "cube", "person"]
    
    var body: some View {
        NavigationView{
        VStack(spacing: 0) {
            ZStack {
                Spacer()
                    .fullScreenCover(isPresented: $showingImagePicker, content: {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                })
                switch selectedIndex {
                case 0:
                    ZStack {
                        Color(#colorLiteral(red: 0.9682741117, green: 0.9682741117, blue: 0.9682741117, alpha: 1)).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        VStack (){
                            Header()
//                           Search()
//                               .padding(.top, 10)
//
                            

                            VStack(alignment: .leading) {
                                Text("Beauty Articles")
                                    .font(.system(size: 22, weight: .bold, design: .serif))
                                    .foregroundColor(Color(#colorLiteral(red: 0.9762545228, green: 0.6769368052, blue: 0.6951140761, alpha: 1)))
                                
                                ScrollView (.horizontal) {
                                    HStack (spacing: 40) {
                                        ForEach(0..<selfNumOfCards.numOfCards){_ in
                                            Card()
                                        }
                                    }
                                }
                                .padding(.top, 0)
                            }
                            .padding(.leading, 30)
                            .padding(.bottom,10)

                            
                            VStack(alignment: .leading) {
                                
                                ScrollView (.vertical) {
                                    VStack (spacing: 0) {
                

                                        AnalysisList(list_size: 2)
                                        ShowMoreButton()
                                            .padding(.top, 120.0)
                                            .frame(height: 2.0)


                                    }
                                }
                                .padding(.top, 0)
                            }
                            .padding(.leading, 0)
                            

                        }
                    }
                   
                case 1:
                    ScrollView {
                        Text("TEST")
                    }
                    
                case 3:
                    ScrollView {
                                  AsyncImage(url: URL(string: UserDefaults.standard.value(forKey: "url") as! String)!,
                                       placeholder: { Text("Loading ...") },
                                       image: { Image(uiImage: $0).resizable()},
                                       numOfCards: selfNumOfCards)
                               .frame(idealHeight: UIScreen.main.bounds.width / 3 * 3)
                    }
                    
                        
                    
                    
                default:
                    NewsView()
             
                }
            }
            
//            Spacer()
            
            Divider()
                .padding(.bottom, 8)
                .background(Color(#colorLiteral(red: 0.9685322642, green: 0.9686941504, blue: 0.9685109258, alpha: 1)))
            HStack {
                ForEach(0..<5) { num in
                    Button(action: {
                        if num == 2 {
                            showingImagePicker.toggle()
                            return
                        }
                        
                        selectedIndex = num
                    }, label: {
                        Spacer()
                        
                        if num == 2 {
                            Image(systemName: tabBarImageNames[num])
                                .font(.system(size: 44, weight: .bold))
                                .foregroundColor(.red)
                        } else {
                            Image(systemName: tabBarImageNames[num])
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(selectedIndex == num ? Color(.black) : .init(white: 1))
                        }
                        Spacer()
                    })
                    
                }
            }.frame(height: 84)
            .frame(maxWidth: .infinity)
            .background(Color(#colorLiteral(red: 0.9762545228, green: 0.6769368052, blue: 0.6951140761, alpha: 1)))
            .cornerRadius(90)
            
            
        }
    }
    
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





}
