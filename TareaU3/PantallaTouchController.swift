//
//  PantallaTouch.swift
//  TareaU3
//
//  Created by Samuel Vasquez on 2/9/16.
//  Copyright (c) 2016 Samuel Vasquez. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication

public class PantallaTouchController: UIViewController {
   
    
    
    // Al presionar el boton Auntenticar por Touch ID en la pantalla inicial
    @IBAction func AutenticarClic(sender: UIButton) {
        autenticarUsuario()
           }
    
    
    func autenticarUsuario()
    {
        // mensaje de error
        var mensajeError : String = ""
        
        
        // contexto de validacion por TouchId
        let context = LAContext()
        
        // variable que registra el posible error que se produzca al intentar autenticar
        var error: 	NSError?
        
        // mensaje que se muestra al usuario al solicitar autenticacion
        let mensaje : String = "Antes de ingresar, debe identificarse como un usuario valido"
        
        
        // Se puede realizar la autenticacion por touchId?
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error)
        {
            // Intentamos realizar autenticacion
            [context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: mensaje, reply: { (resultadoAutenticacion : Bool, errorAlEvaluarPolicy: NSError? ) -> Void in
                if(resultadoAutenticacion)
                {
                    // Autenticacion TouchID correcta
                    // Instancia de la clase Login
                    let login : Login = Login()
                    // intento validar el usuario que tenga asociado el TouchId
                    login.validarPorTouchId()
                    
                    // si hay un usuario correcto, se va a pantalla siguiente
                    if(login.getUsuarioEncontrado())
                    {
                        // asigno variable UsuarioActivoId al identificador del usuaro logueado
                        UsuarioActivoId.instance = login.getUsuarioId()
                         // redirecciono a la pantalla2
                        self.performSegueWithIdentifier("irAPantalla2", sender: self)
                    }
                        // en caso de error, se muestra el motivo del error
                    else
                    {
                        self.mostrarMensaje( login.getMensajeError())
                    }
         
                }
                else
                {
                    switch errorAlEvaluarPolicy!.code
                    {
                    case LAError.AuthenticationFailed.rawValue:
                        mensajeError = "No se pudo identificar huella ingresada por el usuario"
                    case LAError.SystemCancel.rawValue:
                        mensajeError = "Autenticacion cancelada por el sistema"
                    case LAError.UserCancel.rawValue:
                        mensajeError = "Autenticacion cancelada por el usuario"
                    case LAError.UserFallback.rawValue:
                        mensajeError = "Usuario decidio no usar TouchID"
                    default:
                        mensajeError = "Error al autenticar"
                    }
                    self.mostrarMensaje(mensajeError)
                }
            })]
        }
        else
        {
            // No hay sistema de aunteticacion habilitado
            switch error!.code
            {
            case LAError.TouchIDNotEnrolled.rawValue:
                mensajeError = "TouchID no ha enrolado las huellas del usuario"
            case LAError.PasscodeNotSet.rawValue:
                mensajeError = "No se establecido passcode en el dispositivo"
            case LAError.TouchIDNotAvailable.rawValue:
                mensajeError = "TouchID no disponible en el dispositivo"
            default:
                mensajeError = "No hay sistema de autenticacion TocuhId habilitado"
                
            }
            mostrarMensaje(mensajeError)
        }
        
        
    }
    
    func mostrarMensaje(mensajeErrorUsuario : String)
    {
        // si no se pudo identificar, se muestra mensaje al usuario y se va a autenticacion por usuario y contrasena
        let alertController = UIAlertController(title: "Error", message: mensajeErrorUsuario + ". Se debe identificar con nombre de usuario y contrasena", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default)
            {
                (ACTION) -> Void in
                self.performSegueWithIdentifier("irAPantalla1", sender: self)
        }
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}