//
//  ViewController.swift
//  TareaU3
//
//  Created by Samuel Vasquez on 2/2/16.
//  Copyright (c) 2016 Samuel Vasquez. All rights reserved.
//

import UIKit

class Pantalla2Controller: UIViewController {
    
    @IBOutlet weak var lblNombreUsuario: UILabel!
    @IBOutlet weak var lblListado: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        var item = Usuarios.sharedInstance.getById(UsuarioActivoId.instance)
        if(item != nil)
        {
            lblNombreUsuario.text = item?.username
            
            lblListado.text = "Listado de Usuarios ordenados: \n\n"
            
            for item in Usuarios.sharedInstance.getListaOrdenada()
            {
                lblListado.text = lblListado.text! + item.username + "\n"
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        
}

