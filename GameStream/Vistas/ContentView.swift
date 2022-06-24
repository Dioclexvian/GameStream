//
//  ContentView.swift
//  GameStream
//
//  Created by Cobercy apps mobile on 8/06/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
                   ZStack {
                       
                       
                       Color("FondoVoid").ignoresSafeArea()
                       
                       VStack{
                           
                           Image("AppLogo").resizable().aspectRatio(contentMode: .fit)
                               .frame(width: 250)
                               .padding(.bottom, 36.0)
                   
                           InicioYRegistroView()
                           
                       }
                       
                   }.preferredColorScheme(.dark)
                       .navigationBarHidden(true)
                   
                   
               }
           }
       }

struct InicioYRegistroView: View{
               
           @State var tipoInicio = true
           
           var body: some View{
               VStack{
                   HStack {
                       
                       Button("INICIO SESIÓN") {
                           print("pantalla inicio")
                           tipoInicio = true
                       }.foregroundColor(tipoInicio ? Color("Fuschia") : Color("Stark"))
                       
                       Spacer()
                       
                       Button("REGÍSTRATE") {
                           print("pantalla registro")
                           tipoInicio = false
                       }
                       .foregroundColor(tipoInicio ? Color("Stark") : Color("Fuschia"))
                      
                   }.padding(.horizontal, 59)
                   Spacer(minLength: 42)
                   
                   if tipoInicio == true{
                       InicioDeSesionView()
                   }else{
                       InicioRegistroView()
                   }
                   
               }
           }
       }


struct InicioDeSesionView: View {
           @State var Correo = ""
           @State var Contrasena = ""
           @State var IsContrasenaVisible = false
           @State var isPantallaHomeActive = false
           @State var IsDataOK = false
           @Environment(\.openURL) var openURL
           let recuperarDatos = SaveData()
           var body: some View{
               Spacer(minLength: 50)
               ScrollView{
                   
                   VStack(alignment: .leading){
                       
                      
                       Text("Correo electrónico").foregroundColor(Color("Fuschia")).fontWeight(.bold)
                       
                       Spacer(minLength: 30)
                       ZStack(alignment: .leading){
                           if Correo.isEmpty{
                               Text(verbatim: "ejemplo@correo.com").font(.caption).foregroundColor(Color("Stark"))
                           }
                           TextField("", text: $Correo).foregroundColor(Color("Stark"))
                       }
                       Divider().frame(height: 1).background(Color("Fuschia")).padding(.bottom)
                       
                       HStack(){
                           ZStack(alignment: .leading){
                               if Contrasena.isEmpty{
                                   Text("Contraseña").foregroundColor(Color("Stark")).font(.caption)
                               }
                               if !IsContrasenaVisible {
                                   SecureField("", text: $Contrasena).foregroundColor(Color("Stark"))
                               }else{
                                   TextField("", text: $Contrasena).foregroundColor( Color("Stark"))
                               }
                           }
                           Button {
                               IsContrasenaVisible.toggle()
                           } label: {
                               
                               if !IsContrasenaVisible{
                                   Image(systemName: "eye.fill").foregroundColor(Color("Fuschia"))
                               }else{
                                   Image(systemName: "eye.slash.fill").foregroundColor(Color("Fuschia"))
                               }
                               
                               
                           }

                       }
                   
                       
                       Divider().frame(height: 1).background(Color("Fuschia"))
                       
                       Text("Olvidaste tu contraseña?").foregroundColor(Color("Fuschia")).font(.footnote).frame(width: 300, alignment: .trailing).padding(.bottom)
                       
                       
                       Button  {
                           
                           
                           
                           iniciarSesion()
                           
                           
                       } label: {
                           Text("Iniciar Sesión")
                               .fontWeight(.bold)
                               .foregroundColor(Color("Stark"))
                               .frame(maxWidth: .infinity,  alignment: .center)
                               .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                               .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color("Fuschia"), lineWidth: 1.0).shadow(color: Color("Stark"), radius: 6))
                           
                       }.padding(.vertical, 50.0)
                           .alert(isPresented: $IsDataOK ) {
                               Alert(title: Text("ERROR"), message: Text("Los datos ingresados no corresponde con ningún usuario"), dismissButton: .default(Text("Entiendo")))
                           }
                       
                       Text("Inicia sesión con redes sociales").padding(.top, 60)
                                               .foregroundColor(Color("Stark"))
                                               .frame(width: 300, height: 100, alignment: .bottom)
                                               
                       HStack{
                           
                           Button {
                               abrirFacebook()
                           } label: {
                               Text("Facebook").fontWeight(.bold)
                                   .foregroundColor(Color("Stark"))
                                   .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                           }.background(RoundedRectangle(cornerRadius: 6).foregroundColor(Color("Jewel")))

                           Spacer()
                           
                           Button {
                               abrirTwitter()
                           } label: {
                               Text("Twitter").fontWeight(.bold)
                                   .foregroundColor(Color("Stark"))
                                   .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                           }.background(RoundedRectangle(cornerRadius: 6).foregroundColor(Color("Jewel")))


                       }.padding(.horizontal, 35)
                       
                       
                   }.padding(.horizontal, 60.0)
                   
                   NavigationLink(destination: Home(), isActive: $isPantallaHomeActive){
                       EmptyView()
                   }
               }
           }
           
           func abrirFacebook() {
               openURL(URL(string: "https://www.facebook.com")!)
           }
           func abrirTwitter() {
               openURL(URL(string: "https://twitter.com/?lang=es")!)
           }
           
           func iniciarSesion()  {
               
               if recuperarDatos.validar(correo: Correo, contraseña: Contrasena){
                   IsDataOK = false
                   isPantallaHomeActive = true

               }else{
                   IsDataOK = true
               }
               
           }
       }

struct InicioRegistroView: View {
           @State var Correo = ""
           @State var Contrasena = ""
           @State var Contrasena2 = ""
           @State var AlertTitle:String = ""
           @State var AlertMsg:String = ""
           @State var AlertRed:String = ""
           
           @State var IsContrasenaVisible = false
           @State var IsCameraActive = false
           @State var IsContrasenaDos = false
           @State var AreSameContrasena = false
           @State var IsRegistroOK = false

           @State var imagenPerfil: Image? = Image("perfil")
           
           @Environment(\.openURL) var openURL
         
           
           
           var body: some View{
               ScrollView{
                   
                   
                   VStack(alignment: .center){
                       Text("Elige un foto de perfil").fontWeight(.bold)
                           .foregroundColor(Color("Stark"))
                       Text("Puedes cambiar o elegirla más adelante")
                           .font(.footnote)
                           .foregroundColor(Color("Stark"))
                           .fontWeight(.light)
                           .padding(.bottom)
                       
                       Button {
                           IsCameraActive = true
                       } label: {
                           ZStack{
                               imagenPerfil!
                                   .resizable()
                                   .aspectRatio(contentMode: .fill)
                                   .frame(width: 118, height: 118)
                                   .clipShape(Circle())
                                   .sheet(isPresented: $IsCameraActive) {
                                       SUImagePickerView(sourceType: .photoLibrary, image: $imagenPerfil, isPresented: $IsCameraActive)
                                       
                                   }
                               
                               
                               Image(systemName: "camera.shutter.button").frame(width: 50, height: 50, alignment: .center).foregroundColor(Color("Stark"))
                           }
                       }.padding(.bottom)

                       
                       
                   }
                   VStack(alignment: .leading){
                       Text("Correo electrónico*").foregroundColor(Color("Fuschia")).fontWeight(.bold)
                       ZStack(alignment: .leading){
                           if Correo.isEmpty{
                               Text(verbatim: "ejemplo@correo.com").font(.caption).foregroundColor(Color("Stark"))
                           }
                           TextField("", text: $Correo).foregroundColor(Color("Stark"))
                       }
                       Divider().frame(height: 1).background(Color("Fuschia")).padding(.bottom)
                       Text("Contraseña*").foregroundColor(Color("Stark")).fontWeight(.bold).font(.caption)
                       HStack(){
                           
                           ZStack(alignment: .leading){
                           if Contrasena.isEmpty{
                           Text("Contraseña").foregroundColor(Color("Stark")).font(.caption)
                           }
                           
                           
                           if !IsContrasenaVisible {
                               SecureField("", text: $Contrasena).foregroundColor(Color("Stark"))
                           }else{
                               TextField("", text: $Contrasena).foregroundColor( Color("Stark"))
                           }
                           }
                           
                           Button {
                               IsContrasenaVisible.toggle()
                           } label: {

                               if !IsContrasenaVisible{
                                   Image(systemName: "eye.fill").foregroundColor(Color("Fuschia"))
                               }else{
                                   Image(systemName: "eye.slash.fill").foregroundColor(Color("Fuschia"))
                               }
                           }

                       }
                       
                       
                       
                       Divider().frame(height: 1).background(Color("Fuschia"))
                       Text("Confrimar contraseña*").foregroundColor(Color("Stark")).fontWeight(.bold).font(.caption)
                       HStack(){
                           ZStack(alignment: .leading){
                           if Contrasena2.isEmpty{
                           Text("Contraseña").foregroundColor(Color("Stark")).font(.caption)
                           }
                           if !IsContrasenaDos {
                               SecureField("", text: $Contrasena2).foregroundColor(Color("Stark"))
                           }else{
                               TextField("", text: $Contrasena2).foregroundColor( Color("Stark"))
                           }
                           }
                           Button {
                               IsContrasenaDos.toggle()
                           } label: {
                               if !IsContrasenaDos{
                                   Image(systemName: "eye.fill").foregroundColor(Color("Fuschia"))
                               }else{
                                   Image(systemName: "eye.slash.fill").foregroundColor(Color("Fuschia"))
                               }
                           }
                       }
                       Divider().frame(height: 1).background(Color("Fuschia"))
                       
                       Button  {
                           registrate()
                               
                       } label: {
                           Text("REGÍSTRATE")
                               .fontWeight(.bold)
                               .foregroundColor(Color("Stark"))
                               .frame(maxWidth: .infinity,  alignment: .center)
                               .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                               .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color("Fuschia"), lineWidth: 1.0).shadow(color: Color("Stark"), radius: 6))
                       }.padding(.vertical, 40.0)
                       
                           .alert(isPresented: $IsRegistroOK) {
                               
                               Alert(title:Text(AlertTitle), message: Text(AlertMsg), dismissButton: .default(Text("Entendido")))
                           }
                       
                       
                       
                   }.padding(.horizontal, 40.0)
                   
                   
                   
                   if AreSameContrasena {
                       
                       Text(AlertRed)
                        .foregroundColor(.red)
                        .font(.caption)
                   }
                   
                   Spacer()
                       

                   VStack(alignment: .center){
                       Text("Regístrate con redes sociales").foregroundColor(Color("Stark")).frame(width: 300, height: 10)
                       HStack{
                           
                           Button {
                               abrirFacebook()
                           } label: {
                               Text("Facebook").fontWeight(.bold)
                                   .foregroundColor(Color("Stark"))
                                   .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                           }.background(RoundedRectangle(cornerRadius: 6).foregroundColor(Color("Jewel")))
                           Button {
                               abrirTwitter()
                           } label: {
                               Text("Twitter").fontWeight(.bold)
                                   .foregroundColor(Color("Stark"))
                                   .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                           }.background(RoundedRectangle(cornerRadius: 6).foregroundColor(Color("Jewel")))
                       }
                   }
                   
               }
           }
           
           
           
           func abrirFacebook() {
               openURL(URL(string: "https://www.facebook.com")!)
           }
           func abrirTwitter() {
               openURL(URL(string: "https://twitter.com/?lang=es")!)
           }
           
           
           func registrate() {
               
              let objetoActualizadorDatos = SaveData()
               
              if Contrasena == Contrasena2 && Correo != "" {
                  
                  _ = objetoActualizadorDatos.guardarDatos(correo: Correo, contraseña: Contrasena, nombre: "")
                  IsRegistroOK = true
                  AreSameContrasena = false
                  AlertTitle = "OK"
                  AlertMsg = "Se guardaron los datos correctamente"
                  Contrasena = ""
                  Correo = ""
                  Contrasena2 = ""
                  
                  
              }else if (Contrasena != Contrasena2) {
                  IsRegistroOK = true
                  AreSameContrasena = true
                  AlertTitle = "ERROR"
                  AlertMsg = "Verifique que las contraseñas"
                  AlertRed = "Las contraseñas no coinciden"
              } else {
                  
                  IsRegistroOK = true
                  AreSameContrasena = true
                  AlertTitle = "ERROR"
                  AlertMsg = "Verifique el correo"
                  AlertRed = "No escribió ningún correo"
              }
               
               
               
               
            }
           
        
           
       }



       struct ContentView_Previews: PreviewProvider {
           static var previews: some View {
               ContentView()
               
           }
       }
