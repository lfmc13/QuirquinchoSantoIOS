//
//  NavigationVewController.swift
//  NavTransition
//
//  Created by Tope Abayomi on 21/11/2014.
//  Copyright (c) 2014 App Design Vault. All rights reserved.


import Foundation
import UIKit
import CoreData
import SwiftHTTP
import ObjectMapper

class NavigationViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var bgImageView : UIImageView!
    @IBOutlet var tableView   : UITableView!
    @IBOutlet var dimmerView  : UIView!
    
    var items : [NavigationModel]!
    var snapshot : UIView = UIView()
    var transitionOperator = TransitionOperator()
    var currentItem: NSManagedObject!
    var listNoticias:Array<AnyObject> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()
        
        dimmerView.backgroundColor = UIColor(white: 0.0, alpha: 0.3)
        bgImageView.image = UIImage(named: "menu_fondo")
        
        let item1 = NavigationModel(title: "NOTICIAS", icon: "noticias4")
        let item2 = NavigationModel(title: "RESULTADOS", icon: "pronosticos", count: "3")
        let item3 = NavigationModel(title: "EQUIPO", icon: "optionequipo1")
        let item4 = NavigationModel(title: "COMPETICIONES", icon: "competiciones")
        let item5 = NavigationModel(title: "CONFIGURACION", icon: "salir")
        
        items = [item1, item2, item3, item4, item5]
        
        var request = HTTPTask()
        
        request.GET("http://insolwebsite.com/lfmc13/QuirquinchoSantoAdminApp/generarJSON.php?noticias=1", parameters: nil, success: {(response: HTTPResponse) in
            // data is the stream that return the server
            if let data = response.responseObject as? NSData {
                // convert data to String
                
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                // error handler
                var jsonErrorOptional: NSError?
                // parse to JSON
                
                let jsonOptional: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonErrorOptional)
                // Convert JSON to Array [ { }, {json}]
                
                if let statusArray: Array<AnyObject> = jsonOptional as? Array{      // iterate array
                    // map a list of restaurant from array
                
                    self.listNoticias = Mapper<NoticiaMapper>().mapArray(statusArray)!
                    // refresh table
                    
                    
                    for noticia in self.listNoticias {
                        var noticiashow : NoticiaMapper
                        noticiashow = noticia as NoticiaMapper
                        
                        
                        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
                        let contxt:NSManagedObjectContext = appDel.managedObjectContext!
                        let en = NSEntityDescription.entityForName("Noticias", inManagedObjectContext: contxt)
                        
                        var newItem = Noticias(entity:en!, insertIntoManagedObjectContext:contxt)
                        newItem.noticiaid = noticiashow.noticiaid!
                        newItem.titulo = noticiashow.titulo!
                        newItem.textonoticia = noticiashow.textonoticia!
                        newItem.fecha = noticiashow.fecha!
                        newItem.urlimagen = noticiashow.urlimagen!
                        println(newItem)
                        
                    }
                    self.tableView.reloadData()
                    
                }
                
                
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
                println("error: \(error)")
        })

        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let contxt:NSManagedObjectContext = appDel.managedObjectContext!
        let en = NSEntityDescription.entityForName("Noticias", inManagedObjectContext: contxt)
        /*if (currentItem != nil){
            currentItem.setValue("Con la obligación de ganar", forKey: "titulo");
            
            currentItem.setValue("Obligado a ganar -si quiere seguir con vida en el torneo- el cuadro de San José, recibirá esta noche al plantel de Juan Áurich por la quinta fecha del grupo 6 de Copa Libertadores, el partido fue pactado para las 21:15 horas en el estadio Jesús Bermúdez de Oruro", forKey: "textonoticia");
            
            currentItem.setValue("1", forKey: "noticiaid");
            
             currentItem.setValue("25-5-2015", forKey: "fecha");
            
            currentItem.setValue("http://insolwebsite.com/Images/216445_1_07.jpg", forKey: "urlimagen");
            
        } else {
            var newItem = Noticias(entity:en!, insertIntoManagedObjectContext:contxt)
            newItem.noticiaid = "1"
            newItem.titulo = "Con la obligación de ganar"
            newItem.textonoticia = "Obligado a ganar -si quiere seguir con vida en el torneo- el cuadro de San José, recibirá esta noche al plantel de Juan Áurich por la quinta fecha del grupo 6 de Copa Libertadores, el partido fue pactado para las 21:15 horas en el estadio Jesús Bermúdez de Oruro"
            newItem.fecha = "25-5-2015"
            newItem.urlimagen = "http://insolwebsite.com/Images/216445_1_07.jpg"
            println(newItem)
            
        }
        
        contxt.save(nil)
*/
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("NavigationCell") as NavigationCell
        let item = items[indexPath.row]
        
        cell.titleLabel.text = item.title
        cell.countLabel.text = item.count
        cell.iconImageView.image = UIImage(named: item.icon)
        cell.backgroundColor = UIColor.clearColor()
        cell.selectionStyle = .None
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.snapshot.removeFromSuperview()
        
        if (indexPath.row % 2 == 0){
            performSegueWithIdentifier("listview", sender: self)
        }else{
            performSegueWithIdentifier("othernav", sender: self)
        }
    }
    
    func finalizeTransitionWithSnapshot(snapshot: UIView){
        self.snapshot = snapshot
        view.addSubview(self.snapshot)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let toViewController = segue.destinationViewController as UIViewController
        self.modalPresentationStyle = UIModalPresentationStyle.Custom
        toViewController.transitioningDelegate = self.transitionOperator
    }
}

class NavigationModel {
    
    var title : String!
    var icon : String!
    var count : String?
    
    init(title: String, icon : String){
        self.title = title
        self.icon = icon
    }
    
    init(title: String, icon : String, count: String){
        self.title = title
        self.icon = icon
        self.count = count
    }
}
