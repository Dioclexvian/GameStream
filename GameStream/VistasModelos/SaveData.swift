//
//  SaveData.swift
//  GameStream
//
//  Created by Cobercy apps mobile on 8/06/22.
//

import Foundation


class SaveData {
    
    var correo:String = ""
    var contraseña:String = ""
    var nombre: String=""
    
    func guardarDatos (correo:String, contraseña: String, nombre: String) -> Bool {
        print("Dentro de la funcion datos guardar datos obtuve: \(correo), \(contraseña), \(nombre)")
        
        UserDefaults.standard.set([correo, contraseña, nombre], forKey: "datosUsuario")
        
        return true
    }
    
    func recuperarDatos () -> [String] {
        
        let datosUsuario : [String] = UserDefaults.standard.stringArray(forKey: "datosUsuario")!
        
        print("estoy en el metodo recuperar datos y recuperé: \(datosUsuario)")
        
        return datosUsuario
        
    }
    
    func validar(correo:String, contraseña:String) -> Bool{
        
        var correoGuardardo = ""
        var contraseñaGuardada = ""
        
        print("Revisando si tengo datos en user defaults con el correo \(correo) y la contraseña \(contraseña)")
        
        if UserDefaults.standard.object(forKey: "datosUsuario") != nil {
            
            correoGuardardo = UserDefaults.standard.stringArray(forKey: "datosUsuario")![0]
            
            contraseñaGuardada = UserDefaults.standard.stringArray(forKey: "datosUsuario")![1]
            
            print("tenemos aqui el correo guardado \(correoGuardardo) y la contraseña es \(contraseñaGuardada)")
            
            if (correo == correoGuardardo && contraseña == contraseñaGuardada ){
                
                return true
                
            }else {
                
                return false
                
            }
            
        }else{
            
            print("No hay datos de usuario guardados en el user default")
            
            return false
            
        }
        
    }
    
}
