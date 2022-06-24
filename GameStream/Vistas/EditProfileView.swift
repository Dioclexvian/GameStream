//
//  EditProfileView.swift
//  GameStream
//
//  Created by Cobercy apps mobile on 8/06/22.
//

import SwiftUI

struct EditProfileView: View {
   
    @State var imagenPerfil: Image? = Image("perfil")
    @State var isCameraActive: Bool = false
    
    
    
    var body: some View {
        ZStack{
            
            Color("FondoVoid").ignoresSafeArea()
            
            ScrollView{
                
                
                VStack{
                    Text("Editar perfil")
                        .font(.title3)
                        .foregroundColor(Color("Stark"))
                        .padding(.bottom,20)
                        
                    
                    
                    Button {
                        isCameraActive = true
                    }
                     label: {
                        ZStack {
                            imagenPerfil!
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 118, height: 118)
                            .clipShape(Circle())
                            .sheet(isPresented: $isCameraActive) {
                                SUImagePickerView(sourceType: .photoLibrary, image: $imagenPerfil, isPresented: $isCameraActive)
                            }
                            
                            Image(systemName: "camera")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40, alignment: .center)
                                .foregroundColor(Color("Stark"))
                        }
                    }
                   
                    
                    
                    
                    Spacer(minLength: 80)
                    
                    
                    ModuloEditar()
                    
                }.padding(.bottom, 18.0)
                
              
            }
            
            
        }
    }
}


struct ModuloEditar: View{
    
    @State var correo: String  = ""
    @State var contraseña: String = ""
    @State var nombre: String = ""
    @State var IsContraseñaVisible = false
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            Text("Correo electrónico")
                .foregroundColor(Color("Fuschia"))
            
            ZStack(alignment: .leading){
                
                
                
                if correo.isEmpty {
                    
                    Text(verbatim: "ejemplo@mail.com")
                        .font(.caption)
                        .foregroundColor(Color("Stark"))
                }
                
                TextField(" ", text: $correo )
                    .foregroundColor(Color("Stark"))
                
                
            }
            
            Divider()
                .frame( height: 1.0)
                .background(Color("Fuschia"))
            
            
            Text("Contraseña")
                .foregroundColor(Color("Stark"))
            
            HStack(){
                
                ZStack(alignment: .leading){
                    if contraseña.isEmpty{
                        Text("Contraseña")
                            .foregroundColor(Color("Stark"))
                            .font(.caption)
                        
                    }
                    if !IsContraseñaVisible {
                        SecureField("", text: $contraseña).foregroundColor(Color("Stark"))
                    }else{
                        TextField("", text: $contraseña).foregroundColor( Color("Stark"))
                    }
                }
                Button {
                    IsContraseñaVisible.toggle()
                } label: {
                    
                    if !IsContraseñaVisible{
                        Image(systemName: "eye.fill").foregroundColor(Color("Fuschia"))
                    }else{
                        Image(systemName: "eye.slash.fill").foregroundColor(Color("Fuschia"))
                    }
                    
                    
                }

            }
            
            
            Divider().frame(height: 1).background(Color("Fuschia"))
            
            Text("Nombre")
                .foregroundColor(Color("Stark"))
            
            ZStack(alignment: .leading){
                
                if nombre.isEmpty {
                    
                    Text(verbatim: "Introduce tu nombre de usuario")
                        .font(.caption)
                        .foregroundColor(Color("Stark"))
                }
                
                TextField(" ", text: $nombre )
                    .foregroundColor(Color("Stark"))
                
                
            }
            
            Divider()
                .frame( height: 1.0)
                .background(Color("Fuschia"))
            
            
            Button  {
                actualizarDatos()
            } label: {
                Text("ACTUALIZAR DATOS")
                    .fontWeight(.bold)
                    .foregroundColor(Color("Stark"))
                    .frame(maxWidth: .infinity,  alignment: .center)
                    .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color("Fuschia"), lineWidth: 1.0).shadow(color: Color("Stark"), radius: 6))
            }.padding(.vertical, 50.0)
            
            
            
        }.padding(.horizontal, 42.0)
    }
    
    
    func actualizarDatos () {
        
        let objetoActualizadorDatos = SaveData()
        
        let resultado = objetoActualizadorDatos.guardarDatos(correo: correo, contraseña: contraseña, nombre: nombre)
        
        print("Se guardaron los datos del usuario? \(resultado)")
        
        
    }
    
    func datosAsignados () {
        
        let datosDeUsuario = SaveData()
        correo = datosDeUsuario.recuperarDatos()[0]
        contraseña = datosDeUsuario.recuperarDatos()[1]
        nombre = datosDeUsuario.recuperarDatos()[2]
        
        
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
