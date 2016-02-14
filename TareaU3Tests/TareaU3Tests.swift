//
//  TareaU3Tests.swift
//  TareaU3Tests
//
//  Created by Samuel Vasquez on 2/2/16.
//  Copyright (c) 2016 Samuel Vasquez. All rights reserved.
//

import UIKit
import XCTest
import TareaU3

class TareaU3Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUsuarioCorrecto() {
        let login : Login = Login()
        
        login.validarLogin("usuario1", password: "usuario1")
        
        
        XCTAssertEqual(login.getUsuarioEncontrado(), true, "Valida usuario encontrado")
        XCTAssertEqual(login.getErrorEnPassword(), false, "Valida no hay error en password")
        XCTAssertEqual(login.getUsuarioId(), 1, "Valida identificador de usuario")
        XCTAssertEqual(login.getMensajeError(), "", "Valida mensaje de error vacio")
    }
    
    func testUsuarioPasswordIncorrecto() {
        let login : Login = Login()
        
        login.validarLogin("usuario1", password: "password_erronea")
        
        
        XCTAssertEqual(login.getUsuarioEncontrado(), true, "Valida usuario encontrado")
        XCTAssertEqual(login.getErrorEnPassword(), true, "Valida error en password")
        XCTAssertEqual(login.getUsuarioId(), 0, "Valida identificador de usuario")
        XCTAssertEqual(login.getMensajeError(), "No coincide password", "Valida mensaje de error")
    }
    
    func testPerformanceOrdenamiento() {
        // Prueba de perfomance odrdenamiento de lista de usuarios
        self.measureBlock() {
            let objeto : Usuarios! = Usuarios()
            objeto.getListaOrdenada()
        }
    }
    
}
