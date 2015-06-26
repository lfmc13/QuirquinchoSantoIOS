//
//  Noticias.swift
//  NavTransition
//
//  Created by internet on 5/25/15.
//  Copyright (c) 2015 App Design Vault. All rights reserved.
//

import UIKit
import CoreData
@objc (Model)
class Noticias: NSManagedObject {
    @NSManaged var noticiaid:String
    @NSManaged var titulo:String
    @NSManaged var textonoticia:String
    @NSManaged var fuente:String
    @NSManaged var fecha:String
    @NSManaged var urlimagen:String
}

