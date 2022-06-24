//
//  profileView.swift
//  GameStream
//
//  Created by Cobercy apps mobile on 8/06/22.
//

import SwiftUI


struct profileView: View {
    
    @State var nombreUsuario = "Lorem"
    
    @State var imagenPerfil: UIImage = UIImage(named: "perfil")!
    
    let datosModificados = SaveData()
    
    
    var body: some View {
        ZStack{
            Color("FondoVoid").ignoresSafeArea()
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            
            VStack{
                
                Text("PERFIL")
                    .fontWeight(.bold)
                    .foregroundColor(Color("Stark"))
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, alignment: .center)
                
                VStack{
                    
                    Image(uiImage: imagenPerfil)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 118, height: 118)
                        .clipShape(Circle())
                    
                    Text(nombreUsuario)
                        .font(.title3)
                        .foregroundColor(Color("Stark"))
                        .padding()
                    
                }.padding(EdgeInsets(top: 20, leading: 0, bottom: 32, trailing: 0))
                
                
                
                Text("Ajustes")
                    .fontWeight(.bold)
                    .foregroundColor(Color("Stark"))
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, alignment: .leading)
                    .padding(.leading,18)
                
                
                ModuloAjustes()
                
                Spacer()
                
            }
            
        
        
        }.onAppear {
            
            if returnUiImage(named: "fotoDePerfil") != nil {
                
                imagenPerfil = returnUiImage(named: "fotoDePerfil")!
                
                
            }else {
                
                print ("No se encontró foto de perfil ")
            }
            
            print("verificar si tengo datos de usuario en user defaults")
            
            
            
        }
    }
    
    
    func returnUiImage(named: String ) -> UIImage? {
        
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false){
            
            
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        
        return nil
        
    }
}


struct ModuloAjustes:View {
    @State var isToggleOn = true
    @State var isEditPorfileActive = false
    var body: some View{
        VStack(spacing: 3){
            
            Button {
            
            }
                label: {
                    HStack {
                        Text("Cuenta ")
                            .foregroundColor(Color("Stark"))
                        
                        Spacer()
                        
                        Text(">").foregroundColor(Color("Stark"))
                        
                        
                    }.padding()
                }.background(Color("Fuschia"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
               
            
            
            Button {
            
            }
                label: {
                    HStack {
                        Text("Notificaciones ")
                            .foregroundColor(Color("Stark"))
                        
                        Spacer()
                        
                        Toggle("", isOn: $isToggleOn)
                            .toggleStyle(ColoredToggleStyle(onColor: Color("Jewel"), offColor: Color("FondoVoid"), thumbColor: Color("Stark")))
                        
                        
                    }.padding()
                }.background(Color("Fuschia"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
              
            
            Button {
            isEditPorfileActive =  true
            }
                label: {
                    HStack {
                        Text("Editar Perfil ")
                            .foregroundColor(Color("Stark"))
                        
                        Spacer()
                        
                        Text(">").foregroundColor(Color("Stark"))
                        
                        
                    }.padding()
                }.background(Color("Fuschia"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            
            Button {
            
            }
                label: {
                    HStack {
                        Text("Califica esta app ")
                            .foregroundColor(Color("Stark"))
                        
                        Spacer()
                        
                        Text(">").foregroundColor(Color("Stark"))
                        
                        
                    }.padding()
                }.background(Color("Fuschia"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
            NavigationLink(isActive: $isEditPorfileActive) {
                EditProfileView()
            } label: {
                EmptyView()
                
            }

            
        }
    }
}


struct ColoredToggleStyle: ToggleStyle {
    var onColor = Color(UIColor.green)
    var offColor = Color(UIColor.systemGray5)
    var thumbColor = Color.white
    
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.label // The text (or view) portion of the Toggle
            Spacer()
            RoundedRectangle(cornerRadius: 16, style: .circular)
                .fill(configuration.isOn ? onColor : offColor)
                .frame(width: 50, height: 19)
                .overlay(
                    Circle()
                        .fill(thumbColor)
                        .shadow(radius: 1, x: 0, y: 1)
                        .padding(1.5)
                        .offset(x: configuration.isOn ? 10 : -10))
                .animation(Animation.easeInOut(duration: 0.2))
                .onTapGesture { configuration.isOn.toggle() }
        }
        .font(.title)
        
    }
}

struct profileView_Previews: PreviewProvider {
    static var previews: some View {
        profileView()
    }
}
