//
//  Usuarios.swift
//  TareaU3
//
//  Created by Samuel Vasquez on 2/2/16.
//  Copyright (c) 2016 Samuel Vasquez. All rights reserved.
//

import Foundation

class Usuarios
{
    class var sharedInstance: Usuarios
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