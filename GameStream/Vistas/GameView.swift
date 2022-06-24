//
//  GameView.swift
//  GameStream
//
//  Created by Cobercy apps mobile on 8/06/22.
//

import SwiftUI
import AVKit
import Kingfisher

struct GameView: View {
     var url: String
     var titulo: String
     var studio:String
     var calificacion:String
     var yearPublicacion:String
     var descripcion:String
     var tags:[String]
     var imgsUrl:[String]
    
    var body: some View {
        ZStack{
            Color("FondoVoid").ignoresSafeArea()
            VStack{
                video(url: url).frame( height: 300)
                
                ScrollView{
                    
                    VideoInfo(titulo: titulo, studio: studio, calificacion: calificacion, yearPublicacion: yearPublicacion, descripcion: descripcion, tags: tags, imgsUrl: imgsUrl)
                    
                    Gallery(imgsUrl: imgsUrl)
                    
                }.frame(maxWidth: .infinity)
                
            }
            
        }
    }
}


struct video:View{
    var url: String
    var body: some View{
        VideoPlayer(player: AVPlayer(url: URL(string: url)!)).ignoresSafeArea()
    }
}


struct VideoInfo: View {
    var titulo: String
    var studio:String
    var calificacion:String
    var yearPublicacion:String
    var descripcion:String
    var tags:[String]
    var imgsUrl:[String]
    
    var body: some View{
        
        VStack(alignment: .leading){
            
            Text("\(titulo)")
                .foregroundColor(Color("Stark"))
                .font(.largeTitle)
                .padding(.leading)
            
            HStack{
                
                Text("\(studio)")
                    .foregroundColor(Color("Stark"))
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .padding(.top, 5)
                    .padding(.leading)
                    .frame(width: 130, alignment: .leading)
                    
                
                Text("\(calificacion)")
                    .foregroundColor(Color("Stark"))
                    .font(.subheadline)
                    .padding(.top, 5)
                Text("\(yearPublicacion)")
                    .foregroundColor(Color("Stark"))
                    .font(.subheadline)
                    .padding(.top, 5)
                
            }
            
            Text("\(descripcion)")
                .foregroundColor(Color("Stark"))
                .font(.body)
                .padding(.top, 15)
                .padding(.leading)
            
            HStack{
                ForEach(tags, id: \.self){
                    tag in
                    Text("#\(tag)")
                        .foregroundColor(Color("Stark"))
                        .font(.subheadline)
                        .padding(.top, 4)
                        .padding(.leading)
                }
            }
            
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
    
}

struct Gallery: View {
    var imgsUrl: [String]
    let formaGrid = [
        GridItem(.flexible())
    ]
    var body: some View{
        VStack(alignment: .leading){
                Text("GALERÍA" )
                .foregroundColor(Color("Stark"))
                .font(.title)
                .padding(.leading)
            
            ScrollView(.horizontal){
                
                LazyHGrid(rows: formaGrid, spacing: 8 ) {
                    ForEach(imgsUrl, id: \.self){
                        
                        imgUrl in
                        
                        KFImage(URL(string: imgUrl))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        
                        
                        
                        
                    }
                }
                
                
            }.frame( height: 180)
            
            
        }.frame( maxWidth: .infinity, alignment: .leading)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(url: "Ejemplo.com", titulo: "Sonic the headhog", studio: "Sega", calificacion: "E+", yearPublicacion: "1991", descripcion: "Juego de Sega Genesis publicado en 1991 con más de 40 millones de copias vendidas actualmente", tags: ["plataformas","mascota"], imgsUrl: [ "https://cdn.cloudflare.steamstatic.com/steam/apps/268910/ss_615455299355eaf552c638c7ea5b24a8b46e02dd.600x338.jpg","https://cdn.cloudflare.steamstatic.com/steam/apps/268910/ss_615455299355eaf552c638c7ea5b24a8b46e02dd.600x338.jpg","https://cdn.cloudflare.steamstatic.com/steam/apps/268910/ss_615455299355eaf552c638c7ea5b24a8b46e02dd.600x338.jpg"])
    }
}
