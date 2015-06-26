//
//  ViewController.swift
//  NavTransition
//
//  Created by Tope Abayomi on 21/11/2014.
//  Copyright (c) 2014 App Design Vault. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TimelineViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView : UITableView!
    @IBOutlet var menuItem : UIBarButtonItem!
    @IBOutlet var toolbar : UIToolbar!
    var myList:Array<AnyObject> = []
    
    //@IBOutlet weak var ImageBG: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100.0;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
       // ImageBG.image = UIImage(named: "background-web")
        menuItem.image = UIImage(named: "menu")
        toolbar.tintColor = UIColor.blackColor()
        println("Load...SJ")
        var id = UIDevice.currentDevice().identifierForVendor.UUIDString
        println(id)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        println("Load....")
        // Dispose of any resources that can be recreated.
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext!
        let freq = NSFetchRequest (entityName: "Noticias")
        
        myList = context.executeFetchRequest(freq, error: nil)!
        println("Load....")
        tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("Variable..")
        if (segue.identifier == "noticiadetail")
        {   println("show detail")
            var seletedIndex = self.tableView.indexPathForSelectedRow()?.row
            var selectedItem: NSManagedObject = myList[seletedIndex!] as NSManagedObject
            let desti = segue.destinationViewController as NoticiaViewController
            desti.currentItem = selectedItem
        }
    }
    // MARK: - Table view data source
    
   func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return myList.count
    }
    
    
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellID: NSString = "Cell"
        //var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("TimelineCell") as TimelineCell
    
    //cell.textLabel!.text = "test"
        
        var data:NSManagedObject = myList[indexPath.row] as NSManagedObject
    
    
            cell.typeImageView.image = UIImage(named: "ic_quirquincho-web")
            //cell.profileImageView.image = UIImage(named: "profile-pic-1")
  
    
    if let url = NSURL(string: data.valueForKey("urlimagen") as String) {
        if let data = NSData(contentsOfURL: url){
            cell.profileImageView.contentMode = UIViewContentMode.ScaleAspectFit
             cell.profileImageView.image = UIImage(data: data)
        }
    }
    
            cell.nameLabel.text = data.valueForKey("titulo") as? String
            var noticiatitulo : String = data.valueForKey("textonoticia") as String!
    let startIndex = advance(noticiatitulo.startIndex, 0) //advance as   much as you like
    let endIndex = advance(noticiatitulo.startIndex, 130)
    let range = startIndex..<endIndex
    
        noticiatitulo = noticiatitulo.substringWithRange(range)

            cell.postLabel?.text = noticiatitulo
            cell.dateLabel.text = data.valueForKey("fecha") as? String

            return cell
            
    
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    
    // Override to support editing the table view.
   func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let contxt:NSManagedObjectContext = appDel.managedObjectContext!
        
        if editingStyle == UITableViewCellEditingStyle.Delete{
            var deletedItem:NSManagedObject = myList[indexPath.row] as NSManagedObject
            contxt.deleteObject(deletedItem)
            myList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            
        }
        
        contxt.save(nil);
    }
    

    
    /*override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }*/
    
   
    

    @IBAction func dismissNav(sender: AnyObject?){
        dismissViewControllerAnimated(true, completion: nil)
    }
}






