//
//  NoticiaMapper.swift
//  NavTransition
//
//  Created by internet on 6/25/15.
//  Copyright (c) 2015 App Design Vault. All rights reserved.
//



import UIKit
import ObjectMapper
class NoticiaMapper: Mappable {
    // optional ?
    // nullable !
    var noticiaid:String?
    var titulo:String!
    var textonoticia:String!
    var fuente:String!
    var fecha:String!
    var urlimagen:String!
    //init(){}
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    // Mappable
    func mapping(map: Map) {
        noticiaid   <- map["NoticiaID"]
        titulo         <- map["Titulo"]
        textonoticia      <- map["TextoNoticia"]
        fuente     <- map["Fuente"]
        fecha      <- map["Fecha"]
        urlimagen     <- map["UrlImagen"]
        
    }
}
