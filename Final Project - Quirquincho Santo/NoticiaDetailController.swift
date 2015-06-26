//
//  NoticiaDetailController.swift
//  NavTransition
//
//  Created by internet on 5/27/15.
//  Copyright (c) 2015 App Design Vault. All rights reserved.
//
//

import UIKit
import CoreData


class NoticiaViewController: UIViewController {
    
    
    
    @IBOutlet weak var descripciondetalle: UITextView!
    //@IBOutlet weak var descripciondetalle: UILabel!
    @IBOutlet weak var imagendetalle: UIImageView!
    @IBOutlet weak var titulodetalle: UILabel!
    @IBOutlet weak var fechadetalle: UILabel!
    var currentItem: NSManagedObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(currentItem)
        if(currentItem != nil){
            titulodetalle.text = currentItem.valueForKey("titulo") as?  String
            descripciondetalle.text = currentItem.valueForKey("textonoticia") as? String
            
            if let url = NSURL(string: currentItem.valueForKey("urlimagen") as String) {
                if let data = NSData(contentsOfURL: url){
                    imagendetalle.contentMode = UIViewContentMode.ScaleAspectFit
                    imagendetalle.image = UIImage(data: data)
                }
            }
            
            fechadetalle.text = currentItem.valueForKey("fecha") as? String
    
            
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissNav(sender: AnyObject?){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    
}

