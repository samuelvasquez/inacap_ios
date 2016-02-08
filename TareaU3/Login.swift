//
//  Login.swift
//  TareaU3
//
//  Created by Samuel Vasquez on 2/8/16.
//  Copyright (c) 2016 Samuel Vasquez. All rights reserved.
//

import Foundation

public class Login
{
    // Array de usuarios
    var listaUsuarios = Usuarios.sharedInstance
    
    // variable indica si hay contrasena erronea
    var errorEnPassword: Bool = false
    // variable indica si username ingresado existe en la lista de usuarios
    var usuarioEncontrado: Bool = false
    // identificador de usuario ingresado en pantalla de login
    var usuarioId: Int = 0
    // mensaje de error
    var mensajeError : String = ""
    
    public init(){}
    
    public func getErrorEnPassword() -> Bool
    {
        return errorEnPassword
    }
    
    public func getUsuarioEncontrado() -> Bool
    {
        return usuarioEncontrado
    }
    
    public func getUsuarioId() -> Int
    {
        return usuarioId
    }
    
    public func getMensajeError() -> String
    {
        return mensajeError
    }
    
    
    public func validarLogin(username : String, password : String)
    {
        mensajeError  = ""
        // variable indica si hay contrasena erronea
        errorEnPassword = false
        // variable indica si username ingresado existe en la lista de usuarios
        usuarioEncontrado = false
        // identificador de usuario ingresado en pantalla de login
        usuarioId = 0
        
        if username.isEmpty
        {
            mensajeError = "Debe indicar nombre de usuario"
            return
        }
        if password.isEmpty
        {
            mensajeError = "Debe indicar contrasena"
            return
        }
        
        // recorro la lista de usuarios, buscando si existe un usuario que coincida con el username ingresado por el usuario
        let usuarios = listaUsuarios.getLista() as [Usuario]
        for itemUsuario in usuarios
        {
            if(itemUsuario.username == username)
            {
                usuarioEncontrado = true
                // si coincide la contrasena, se guarda id de usuario
                if(itemUsuario.password == password)
                {
                    usuarioId = itemUsuario.id
                }
                else
                {
                    errorEnPassword = true
                }
            }
        }
        
        // si hay un usuario correcto, se carga listado de clientes
        if(usuarioEncontrado && !errorEnPassword)
        {
            UsuarioActivoId.instance = usuarioId
        }
            // en caso de error, se muestra el motivo del error
        else
        {
            if(!usuarioEncontrado)
            {
                mensajeError = "No se encuentra usuario"
            }
            else if(errorEnPassword)
            {
                mensajeError = "No coincide password"
            }
        }
    }

}