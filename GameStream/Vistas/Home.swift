//
//  Home.swift
//  GameStream
//
//  Created by Cobercy apps mobile on 8/06/22.
//

import SwiftUI
import AVKit

struct Home: View {
    @State var tagSelecionado: Int = 2
    
    var body: some View {
        
        
        TabView(selection: $tagSelecionado){
            
            profileView()
            .tabItem{
                Image(systemName:   "person.circle")
                Text("PERFIL")
            }.tag(0)
            
            
            gamesView()
                .tabItem{
                Image(systemName:   "r.joystick.press.down")
                Text("JUEGOS")
            }.tag(1)
            
           
           PantallaHome()
            .tabItem{
                Image(systemName:   "house.circle")
                Text("INICIO")
            }.tag(2)
            
            
            FavViews()
            .tabItem{
                Image(systemName:   "heart.circle")
                Text("FAVORITOS")
            }.tag(3)
        }.accentColor(Color("Stark"))
    }
    
    init (){
        UITabBar.appearance().backgroundColor = UIColor(Color("FondoVoid"))
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color("Fuschia"))
        UITabBar.appearance().isTranslucent = true
    }
    
       
    
}

struct PantallaHome: View {
    
    var body: some View {
        
            ZStack{
                    Color( "FondoVoid").ignoresSafeArea()
                    
                        VStack{
                            Image("AppLogo").resizable().aspectRatio(contentMode: .fit)
                                .frame(width: 250)
                                .padding([.leading, .bottom, .trailing], 24.0)
                            
                           
                    
                            ScrollView(showsIndicators: false){
                                subModuloHome()
                            }
                            
                        }.padding(.horizontal, 18)
                
                Spacer()
            }.navigationBarBackButtonHidden(true).navigationBarHidden(true)
            
        
            
           
        
    }
    
}

struct subModuloHome: View {
    @State var textoBusqueda : String = ""
    @State var isGameInfoEmpty = false
    @ObservedObject var juegoEncontrado = SearchGame()
    @State var isGameActive = false
    
    @State var url: String = ""
    @State var titulo: String = ""
    @State var studio:String = ""
    @State var calificacion:String = ""
    @State var yearPublicacion:String  = ""
    @State var descripcion:String = ""
    @State var tags:[String] = [""]
    @State var imgsUrl:[String] = [""]
    
    
    var body: some View{
        
    VStack {
        
        HStack{
            
            Button(action: {
                
                watchName(name: textoBusqueda)
                
            },
            label: {
                Image(systemName: "magnifyingglass.circle")
                    .foregroundColor(textoBusqueda.isEmpty ? Color("Stark") : Color("Stark") )
            }).alert(isPresented: $isGameInfoEmpty) {
                Alert(title: Text("Error"), message: Text("No se encontró el juego"), dismissButton: .default(  Text("Entendido")))
            }
            
            ZStack(alignment: .leading){
                if textoBusqueda.isEmpty{
                    Text("Buscar un video").foregroundColor(Color("Stark"))
                }
                TextField(" ", text: $textoBusqueda).foregroundColor(Color("Stark"))
            }
            
        }
        .padding([.top, .leading, .bottom], 11)
        .background(Color("JewelDark"))
        .clipShape(Capsule())
        
        
        Text("LOS MÁS POPULARES").font(.title3)
            .foregroundColor(.white)
            .bold()
            .frame(minWidth: 0, maxWidth: .infinity,  alignment: .leading)
            .padding(.top)
        
        ZStack{
            
            Button {
                watchName(name: "The Witcher 3")
            } label: {
                
                VStack(spacing: 0){
                    Image("The Witcher 3").resizable()
                        .scaledToFit()
                        .border(Color("JewelDark"), width: 4)
                    Text("The Witcher 3: Wild Hunt").font(.title3)
                        .bold()
                        .frame(minWidth: 0, maxWidth: .infinity,  alignment: .leading)
                        .background(Color("JewelDark"))
                        .foregroundColor(Color("Stark"))
                }
                
            }
            
            Image(systemName: "play.circle").resizable()
                .foregroundColor(Color("Stark"))
                .frame(width: 42, height: 42)
                
            
            
        }.frame(minWidth: 0, maxWidth: .infinity,  alignment: .leading)
            .padding(.vertical)
            
        
        Text("CATEGORÍAS SUGERIDAS PARA TI").font(.title3)
            .foregroundColor(Color("Stark"))
            .bold()
            .frame(minWidth: 0, maxWidth: .infinity,  alignment: .leading)
            .padding(.top, 15)
            
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                
                
                Button {
                    
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 9)
                            .fill(Color("JewelDark"))
                            .frame(width: 160, height: 90)
                        
                        VStack {
                            Image(systemName: "scope").resizable()
                                .scaledToFit()
                                .frame(width: 42, height: 42)
                            .foregroundColor(Color("Fuschia"))
                            
                            Text("FPS")
                                .font(.title3)
                                .bold()
                                .foregroundColor(Color("Stark"))
                        }
                    }
                }
                
                Button {
                    
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 9)
                            .fill(Color("JewelDark"))
                            .frame(width: 160, height: 90)
                        
                        VStack {
                            Image("rpg-icon").resizable()
                                .scaledToFit()
                            .frame(width: 42, height: 42)
                            
                            Text("RPG")
                                .font(.title3)
                                .bold()
                                .foregroundColor(Color("Stark"))
                        }
                    }
                }
                
                
                Button {
                    
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 9)
                            .fill(Color("JewelDark"))
                            .frame(width: 160, height: 90)
                        
                        VStack {
                            Image(systemName: "globe.americas.fill").resizable()
                                .scaledToFit()
                                .foregroundColor(Color("Fuschia"))
                            .frame(width: 42, height: 42)
                            
                            Text("Open World")
                                .font(.title3)
                                .bold()
                                .foregroundColor(Color("Stark"))
                        }
                    }
                }
                
                
            }
        }
        
        Text("RECOMENDADOS PARA TI").font(.title3)
            .foregroundColor(Color("Stark"))
            .bold()
            .frame(minWidth: 0, maxWidth: .infinity,  alignment: .leading)
            .padding(.top, 30)
        
        ScrollView(.horizontal, showsIndicators: false){
            
            HStack{
                
                Button {
                    watchName(name: "Abzu")
                } label: {
                    ZStack{
                    Image("Abzu").resizable()
                        .scaledToFit()
                        .frame(width: 240, height: 135)
                        .border(Color("Jewel"), width: 0.5)
                        
                        LinearGradient(colors: [Color("Trans"),Color("FondoVoid")], startPoint: .init(x: 0, y: 0.66), endPoint: .init(x: 0, y: 0.9))
                        VStack{
                            Spacer()
                            
                            HStack {
                                Image(systemName: "globe.americas")
                                    .foregroundColor(Color("Fuschia"))
                                
                                Text("Abzu")
                                    .font(.title3)
                                    .bold()
                                .foregroundColor(Color("Stark"))
                            }
                            
                            
                            
                        }
                        
                    }
                }
                
                
                Button {
                    watchName(name: "Crash Bandicoot")
                } label: {
                    ZStack{
                    Image("Crash Bandicoot").resizable()
                        .scaledToFit()
                        .frame(width: 240, height: 135)
                        .border(Color("Jewel"), width: 0.5)
                        
                        LinearGradient(colors: [Color("Trans"),Color("FondoVoid")], startPoint: .init(x: 0, y: 0.66), endPoint: .init(x: 0, y: 0.9))
                        VStack{
                            Spacer()
                            
                            HStack {
                                Image(systemName: "wind")
                                    .foregroundColor(Color("Fuschia"))
                                    .rotationEffect(.degrees(180))
                                Image(systemName: "hare")
                                    .foregroundColor(Color("Fuschia"))
                                Text("Crash Bandicoot")
                                    .font(.title3)
                                    .bold()
                                .foregroundColor(Color("Stark"))
                            }
                        }
                    }
                }
                
                
                Button {
                    watchName(name: "DEATH STRANDING")
                } label: {
                    ZStack{
                    Image("DEATH STRANDING").resizable()
                        .scaledToFit()
                        .frame(width: 240, height: 135)
                        .border(Color("Jewel"), width: 0.5)
                        
                        LinearGradient(colors: [Color("Trans"),Color("FondoVoid")], startPoint: .init(x: 0, y: 0.66), endPoint: .init(x: 0, y: 0.9))
                        VStack{
                            Spacer()
                            
                            HStack {
                                Image(systemName: "figure.walk")
                                    .foregroundColor(Color("Fuschia"))
                                   
                                Image(systemName: "shippingbox")
                                    .foregroundColor(Color("Fuschia"))
                                
                                Text("Death Stranding")
                                    .font(.title3)
                                    .bold()
                                .foregroundColor(Color("Stark"))
                            }
                        }
                    }
                }

                
            }
            
        }
        
        
        Text("VIDEOS QUE PODRÍAN GUSTARTE").font(.title3)
            .foregroundColor(Color("Stark"))
            .bold()
            .frame(minWidth: 0, maxWidth: .infinity,  alignment: .leading)
            .padding(.top, 30)
        
        ScrollView(.horizontal, showsIndicators: false){
            
            HStack{
                
                Button {
                    watchName(name: "Cuphead")
                } label: {
                    ZStack{
                    Image("Cuphead").resizable()
                        .scaledToFit()
                        .frame(width: 240, height: 135)
                        .border(Color("Jewel"), width: 0.5)
                        
                        LinearGradient(colors: [Color("Trans"),Color("FondoVoid")], startPoint: .init(x: 0, y: 0.66), endPoint: .init(x: 0, y: 0.9))
                        VStack{
                            Spacer()
                            
                            HStack {
                                Image(systemName: "wind")
                                    .foregroundColor(Color("Fuschia"))
                                    .rotationEffect(.degrees(180))
                                Image(systemName: "hare")
                                    .foregroundColor(Color("Fuschia"))
                                Text("Cuphead")
                                    .font(.title3)
                                    .bold()
                                .foregroundColor(Color("Stark"))
                            }
                        }
                    }
                }
                
                Button {
                    watchName(name: "Hades")
                } label: {
                    ZStack{
                    Image("Hades").resizable()
                        .scaledToFit()
                        .frame(width: 240, height: 135)
                        .border(Color("Jewel"), width: 0.5)
                        
                        LinearGradient(colors: [Color("Trans"),Color("FondoVoid")], startPoint: .init(x: 0, y: 0.66), endPoint: .init(x: 0, y: 0.9))
                        VStack{
                            Spacer()
                            
                            HStack {
                                Image(systemName: "figure.walk")
                                    .foregroundColor(Color("Fuschia"))
                                Image(systemName: "arrow.triangle.branch")
                                    .foregroundColor(Color("Fuschia"))
                                Text("Hades")
                                    .font(.title3)
                                    .bold()
                                .foregroundColor(Color("Stark"))
                            }
                        }
                    }
                }
                
                Button {
                    watchName(name: "Grand Theft Auto V")
                } label: {
                    ZStack{
                    Image("Grand Theft Auto V").resizable()
                        .scaledToFit()
                        .frame(width: 240, height: 135)
                        .border(Color("Jewel"), width: 0.5)
                        
                        LinearGradient(colors: [Color("Trans"),Color("FondoVoid")], startPoint: .init(x: 0, y: 0.66), endPoint: .init(x: 0, y: 0.9))
                        VStack{
                            Spacer()
                            
                            HStack {
                                Image(systemName: "globe.americas")
                                    .foregroundColor(Color("Fuschia"))
                                Text("GTA V")
                                    .font(.title3)
                                    .bold()
                                .foregroundColor(Color("Stark"))
                            }
                        }
                    }
                }
            }
            
        }
        
    }
        
        NavigationLink(destination: GameView(url: url, titulo: titulo, studio: studio, calificacion: calificacion, yearPublicacion: yearPublicacion, descripcion: descripcion, tags: tags, imgsUrl: imgsUrl)
                       , isActive: $isGameActive) {
                        EmptyView()
        }
    
    }
    
    func watchName (name: String) {
        
        juegoEncontrado.search(gameName: name)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3){
            
            print("Cantidad E: \(juegoEncontrado.gameInfo.count)")
            
            if juegoEncontrado.gameInfo.count == 0 {
                
                isGameInfoEmpty = true
            }else {
                url = juegoEncontrado.gameInfo[0].videosUrls.mobile
                titulo = juegoEncontrado.gameInfo[0].title
                studio = juegoEncontrado.gameInfo[0].studio
                calificacion = juegoEncontrado.gameInfo[0].contentRaiting
                yearPublicacion = juegoEncontrado.gameInfo[0].publicationYear
                descripcion = juegoEncontrado.gameInfo[0].description
                tags = juegoEncontrado.gameInfo[0].tags
                imgsUrl = juegoEncontrado.gameInfo[0].galleryImages
                
                isGameActive = true
                
                
                
            }
            
        }
    }
}



struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
        
    }
}
