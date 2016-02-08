//
//  Usuarios.swift
//  TareaU3
//
//  Created by Samuel Vasquez on 2/2/16.
//  Copyright (c) 2016 Samuel Vasquez. All rights reserved.
//

import Foundation

public class Usuarios
{
    public class var sharedInstance: Usuarios
    {
        struct Static{
            static var instance: Usuarios?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token)
            {
                Static.instance = Usuarios()
        }
        
        return Static.instance!
    }
    
    private var modelUpdated = false
    private var listaUsuarios = [Usuario]()
    
    public init()
    {
        // Inicializa el listado de usuarios.
        listaUsuarios.append(Usuario(id: 1, username: "usuario1", password: "usuario1", borrado: false))
        listaUsuarios.append(Usuario(id: 2, username: "usuario2", password: "usuario2", borrado: false))
        listaUsuarios.append(Usuario(id: 3, username: "demo10", password: "demo10", borrado: false))
        listaUsuarios.append(Usuario(id: 4, username: "prueba", password: "prueba", borrado: false))
        listaUsuarios.append(Usuario(id: 5, username: "svasquez", password: "svasquez", borrado: false))
        listaUsuarios.append(Usuario(id: 6, username: "pcruz", password: "pcruz", borrado: false))
        listaUsuarios.append(Usuario(id: 7, username: "abc", password: "abc", borrado: false))
        listaUsuarios.append(Usuario(id: 8, username: "ztapia", password: "ztapia", borrado: false))
        listaUsuarios.append(Usuario(id: 9, username: "demo2", password: "demo2", borrado: false))
        listaUsuarios.append(Usuario(id: 10, username: "admin", password: "admin123", borrado: false))
   }
    
    func getLista() -> NSArray
    {
        var notDeleted = [Usuario]()
        for item in listaUsuarios
        {
            if !item.borrado
            {
                notDeleted.append(item)
            }
        }
        return notDeleted
    }
    
    // Ordenamiento de usuario con codigo burbuja
    public func getListaOrdenada() -> NSArray
    {
        var usuarios = listaUsuarios
        var total = usuarios.count
        var contador1 : Int = 0
        var aux : Usuario
        while contador1 < total{
            var contador2 : Int = 0
            while contador2 < total  - 1{
               if usuarios[contador2].username > usuarios[contador2 + 1].username
                {
                    aux = usuarios[contador2]
                    usuarios[contador2] = usuarios[contador2 + 1]
                    usuarios[contador2 + 1] = aux
                }
                contador2 = contador2 + 1
            }
            
            contador1 = contador1 + 1
        }
        return usuarios
    }
    
    // Retorna listaUsuarios por ID
    func getById(id: Int) -> Usuario?
    {
        var posicion : Int = 0
        while(posicion < listaUsuarios.count)
        {
            if listaUsuarios[posicion].id == id
            {
                return listaUsuarios[posicion]
            }
            posicion = posicion + 1
        }
        return nil
    }
    
    func delete(index: Int)
    {
        let item = listaUsuarios[index]
        item.borrado = true
        listaUsuarios[index] = item
    }
    
    func add(item: Usuario)
    {
        listaUsuarios.append(item)
    }
    
    func update(original: Usuario, actualizado: Usuario)
    {
        if let posicion = find(listaUsuarios, original)
        {
            listaUsuarios[posicion] = actualizado
            modelUpdated = true;
        }
    }
    
    func hasChanged() -> Bool
    {
        if(modelUpdated)
        {
            modelUpdated = false
            return true
        }
        return false
    }
    
}