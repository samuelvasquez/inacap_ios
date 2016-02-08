//
//  ViewController.swift
//  TareaU3
//
//  Created by Samuel Vasquez on 2/2/16.
//  Copyright (c) 2016 Samuel Vasquez. All rights reserved.
//

import UIKit

public class Pantalla1Controller: UIViewController {

    @IBOutlet weak var txtNombreUsuario: UITextField!
    @IBOutlet weak var txtContrasena: UITextField!
    @IBOutlet weak var lblMensajeError: UILabel!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Clic en boton Ingresar, validacion de datos 
    // Si esta todo OK, va a pantalla 2
    @IBAction func btnIngresarClic(sender: UIButton) {
        var login : Login = Login()
        
        login.validarLogin(txtNombreUsuario.text, password: txtContrasena.text)
        
        // si hay un usuario correcto, se carga listado de clientes
        if(login.getUsuarioEncontrado() && !login.getErrorEnPassword())
        {
            UsuarioActivoId.instance = login.getUsuarioId()
            txtNombreUsuario.text = ""
            txtContrasena.text = ""
            self.performSegueWithIdentifier("irAPantalla2", sender: self)
        }
            // en caso de error, se muestra el motivo del error
        else
        {
            lblMensajeError.text = login.getMensajeError()
        }
    }
    
       
    // Clic en boton Limpiar, limpiar la pantalla
    @IBAction func btnLimpiarClic(sender: UIButton) {
        txtNombreUsuario.text = ""
        txtContrasena.text = ""
        lblMensajeError.text = ""
    }
    
}

