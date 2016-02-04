//
//  ViewController.swift
//  TareaU3
//
//  Created by Samuel Vasquez on 2/2/16.
//  Copyright (c) 2016 Samuel Vasquez. All rights reserved.
//

import UIKit

class Pantalla1Controller: UIViewController {

    @IBOutlet weak var txtNombreUsuario: UITextField!
    @IBOutlet weak var txtContrasena: UITextField!
    @IBOutlet weak var lblMensajeError: UILabel!
    
    // Array de usuarios
    var listaUsuarios = Usuarios.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Inicializa el listado de usuarios.
        listaUsuarios.add(Usuario(id: 1, username: "usuario1", password: "usuario1", borrado: false))
        listaUsuarios.add(Usuario(id: 2, username: "usuario2", password: "usuario2", borrado: false))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Clic en boton Ingresar, validacion de datos 
    // Si esta todo OK, va a pantalla 2
    @IBAction func btnIngresarClic(sender: UIButton) {
        lblMensajeError.text  = ""
        
        if txtNombreUsuario.text.isEmpty
        {
            lblMensajeError.text = "Debe indicar nombre de usuario"
            return
        }
        if txtContrasena.text.isEmpty
        {
            lblMensajeError.text = "Debe indicar contrasena"
            return
        }
        
        // variable indica si hay contrasena erronea
        var errorEnPassword: Bool = false
        // variable indica si username ingresado existe en la lista de usuarios
        var usuarioEncontrado: Bool = false
        // identificador de usuario ingresado en pantalla de login
        var usuarioId: Int = 0
        
        // recorro la lista de usuarios, buscando si existe un usuario que coincida con el username ingresado por el usuario
        let usuarios = listaUsuarios.getLista() as [Usuario]
        for itemUsuario in usuarios
        {
            if(itemUsuario.username == txtNombreUsuario.text)
            {
                usuarioEncontrado = true
                // si coincide la contrasena, se guarda id de usuario
                if(itemUsuario.password == txtContrasena.text)
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
            txtNombreUsuario.text = ""
            txtContrasena.text = ""
            self.performSegueWithIdentifier("irAPantalla2", sender: self)
        }
            // en caso de error, se muestra el motivo del error
        else
        {
            if(!usuarioEncontrado)
            {
                lblMensajeError.text = "No se encuentra usuario"
            }
            else if(errorEnPassword)
            {
                lblMensajeError.text = "No coincide password"
            }
        }
    }
    
    // Clic en boton Limpiar, limpiar la pantalla
    @IBAction func btnLimpiarClic(sender: UIButton) {
        txtNombreUsuario.text = ""
        txtContrasena.text = ""
        lblMensajeError.text = ""
    }
    
}

