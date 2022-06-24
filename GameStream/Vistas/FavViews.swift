//
//  FavViews.swift
//  GameStream
//
//  Created by Cobercy apps mobile on 8/06/22.
//

import SwiftUI
import AVKit


    struct FavViews: View {
        @ObservedObject var todosLosVideojuegos = ViewModel()
        
        var body: some View {
            
            ZStack{
                Color( "FondoVoid").ignoresSafeArea()
                
                VStack{
                    Text( " TUS FAVORITOS").font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("Stark"))
                        .padding(.bottom, 9.0)
                    
                    ScrollView{
                        ForEach(todosLosVideojuegos.gamesInfo, id: \.self) {
                            juego in
                            VStack( spacing: 0) {
                                VideoPlayer(player: AVPlayer(url: URL(string: juego.videosUrls.mobile)!))
                                    .frame(height: 300)
                                
                                Text("\(juego.title)")
                                    .foregroundColor(Color("Stark"))
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color("JewelDark"))
                                    .border(Color("JewelDark"), width: 2)
                                    .clipShape(RoundedRectangle(cornerRadius: 3.0))
                            }
                            
                            
                        }
                        
                    }.padding(.bottom, 8.0)
                    
                }.padding(.horizontal, 6.0)
                
                
            }.navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            
            
           
        }
    }

    struct FavViews_Previews: PreviewProvider {
        static var previews: some View {
            FavViews()
        }
    }
