//
//  Usuario.swift
//  TareaU3
//
//  Created by Samuel Vasquez on 2/2/16.
//  Copyright (c) 2016 Samuel Vasquez. All rights reserved.
//

import Foundation

// Clase para almacenar la informacion de cada usuario
class Usuario: NSObject
{
    // Identificador unico
    var id: Int
    // Nombre de usuario
    var username: String
    // Contrasena
    var password: String
    // Indicador de borrado logico
    var borrado: Bool
    
    // constructor
    init(id: Int, username: String, password: String, borrado: Bool)
    {
        self.id = id
        self.username = username
        self.password = password
        self.borrado = borrado
    }
}