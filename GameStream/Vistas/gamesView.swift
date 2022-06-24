//
//  gamesView.swift
//  GameStream
//
//  Created by Cobercy apps mobile on 8/06/22.
//

import SwiftUI
import Kingfisher

struct gamesView: View {
    @ObservedObject var todosLosVideojuegos = ViewModel()
    
    @State var gameViewIsActive: Bool = false
    @State var url: String = ""
    @State var titulo: String = ""
    @State var studio:String = ""
    @State var calificacion:String = ""
    @State var yearPublicacion:String  = ""
    @State var descripcion:String = ""
    @State var tags:[String] = [""]
    @State var imgsUrl:[String] = [""]
    
    
    let formaGrid = [
        
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    var body: some View {
        
        ZStack{
            Color("FondoVoid").ignoresSafeArea()
            
            VStack{
                Text("Juegos")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color("Stark"))
                    .padding(EdgeInsets (top: 16, leading: 0, bottom: 64, trailing: 0))
                
                ScrollView{
                    
                    LazyVGrid(columns: formaGrid, spacing: 8){
                        ForEach(todosLosVideojuegos.gamesInfo, id: \.self){
                            juego in
                            
                            Button {
                                
                                
                                url = juego.videosUrls.mobile
                                titulo = juego.title
                                studio = juego.studio
                                calificacion = juego.contentRaiting
                                yearPublicacion = juego.publicationYear
                                descripcion = juego.description
                                tags = juego.tags
                                imgsUrl = juego.galleryImages
                                
                                print("pulsé el juego \(titulo)")
                                
                                gameViewIsActive = true
                                
                                
                                
                                
                                
                            } label: {
                                ZStack{
                                    
                                    
                                KFImage(URL(string: juego.galleryImages[0])!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(RoundedRectangle
                                        .init(cornerRadius: 4))
                                    .padding(.bottom, 12)
                                    .border(Color("Jewel"), width: 0.5)
                                    
                                    LinearGradient(colors: [Color("Trans"),Color("FondoVoid")], startPoint: .init(x: 0, y: 0.66), endPoint: .init(x: 0, y: 0.9))
                                    
                                    VStack{
                                        Spacer()
                                        
                                        Text(juego.title)
                                            .font(.caption)
                                            .bold()
                                            .foregroundColor(Color("Stark"))
                                            
                                        
                                    }
                                    
                                }
                                
                                
                                
                                
                                
//                                AsyncImage(url: URL(string: juego.galleryImages[0])!){
//                                    image in image.resizable().aspectRatio(contentMode: .fit)
//                                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
//                                        .clipShape(RoundedRectangle(cornerRadius: 8))
//                                        .frame(width: 200, height: 200)
//                                }placeholder: {
//                                    ProgressView(value: 0.75)
//                                }
//
                                
                                
                            }

                        }
                    }
                }
                
            }.padding(.horizontal, 6)
            
            NavigationLink(isActive: $gameViewIsActive) {
                GameView(url: url, titulo: titulo, studio: studio, calificacion: calificacion, yearPublicacion: yearPublicacion, descripcion: descripcion, tags: tags, imgsUrl: imgsUrl)
            } label: {
                EmptyView()
            }

            
        }.navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear(
                perform: {
                  print("primer elemento del json: \(todosLosVideojuegos.gamesInfo[0])")
                  print("Titulo del primer videojuego del json: \(todosLosVideojuegos.gamesInfo[0].title)")
                }
            )
    }
}

struct gamesView_Previews: PreviewProvider {
    static var previews: some View {
        gamesView()
    }
}
