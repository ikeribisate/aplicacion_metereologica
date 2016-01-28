//
//  MyTableViewController.swift
//  tiempo
//
//  Created by Antonio on 1/12/16.
//  Copyright © 2016 Antonio. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController, NSXMLParserDelegate
{
    
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var fecha = NSMutableString()
    var lluvia = NSMutableString()
    var nieve = NSMutableString()
    var cielo = NSMutableString()
    var cielo_des = NSMutableString()
    var v_dir = NSMutableString()
    var v_vel = NSMutableString()
    var t_max = NSMutableString()
    var t_min = NSMutableString()
    var h_max = NSMutableString()
    var h_min = NSMutableString()
    
    var sw=""
    var periodo=""
    var cielo_d=""
    var p=""
    var prueba="N A D A"
    var ifDirOK = false
    
    var iconos_c:Array <String> = ["00","00n",
                                   "11","11n",
                                   "12","12n",
                                   "14","14c",
                                   "15","15c"]
    var iconos_i:Array <String> = ["Nieve.jpg" ,"Nieve.jpg",
                                   "Sol2.jpg"  ,"Sol2.jpg",
                                   "Nubes4.jpg","Nubes4.jpg",
                                   "Nubes3.jpg","Nubes3.jpg",
                                   "Nubes2.jpg","Nubes2.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.beginParsing()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    func beginParsing()
    {
        posts = []

// PENDIENTE .... 1 CONEXION A WEB
        let url: NSURL! = NSBundle.mainBundle().URLForResource("localidad_01059", withExtension: "xml")
        //let url = NSURL(string: "http://www.aemet.es/xml/municipios/localidad_01059.xml")
        
        //let url = NSURL(string: "http://images.apple.com/main/rss/hotnews/hotnews.rss")
        //let url: NSURL! = NSBundle.mainBundle().URLForResource("noticia", withExtension: "do")

        
        //parser = NSXMLParser(contentsOfURL:(NSURL(string:"http://images.apple.com/main/rss/hotnews/hotnews.rss"))!)!
        //parser = NSXMLParser(contentsOfURL:(NSURL(string:"http://www.aemet.es/xml/municipios/localidad_01059.xml"))!)!
        //parser = NSXMLParser(contentsOfURL:(NSURL(string:"http://www.w3schools.com/xml/cd_catalog.xml"))!)!
        
        parser = NSXMLParser(contentsOfURL:(url)!)!
        parser.delegate = self
        parser.parse()
    }
    
    //XMLParser Methods
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
      
        element = elementName
        if (elementName as NSString).isEqualToString("dia")
        {
            elements = NSMutableDictionary()
            elements = [:]

            fecha = NSMutableString()
            fecha = ""
            lluvia = NSMutableString()
            lluvia = ""
            nieve = NSMutableString()
            nieve = ""
            cielo = NSMutableString()
            cielo = ""
            cielo_des = NSMutableString()
            cielo_des = ""
            p=""
            v_dir = NSMutableString()
            v_dir = ""
            v_vel = NSMutableString()
            v_vel = ""
            t_max = NSMutableString()
            t_max = ""
            t_min = NSMutableString()
            t_min = ""
            h_max = NSMutableString()
            h_max = ""
            h_min = NSMutableString()
            h_min = ""
            
            fecha.appendString(attributeDict["fecha"]!)
        }
        
        else if (elementName as NSString).isEqualToString("prob_precipitacion") ||
                (elementName as NSString).isEqualToString("cota_nieve_prov")    ||
                (elementName as NSString).isEqualToString("estado_cielo")
        {
            periodo="00-24"
// PENDIENTE .... 6 PREGUNTAR POR UN ATRIBUTO QUE NO EXISTE
            //periodo=attributeDict["periodo"]!

            //if !attributeDict["periodo"]!.isEmpty 
            //if let item = attributeDict["periodo"]!
            //{
            //    periodo=attributeDict["periodo"]!
            //}
            
            if (elementName as NSString).isEqualToString("estado_cielo") && (periodo == "00-24") {
                if p == "" {
                    if !attributeDict["descripcion"]!.isEmpty {
                        cielo_d=attributeDict["descripcion"]!
                        //cielo_des.appendString(attributeDict["descripcion"]!)
                        p="S"
                      }
                 }
            }
        }
        else if (elementName as NSString).isEqualToString("temperatura")
        {
            sw="T"
        }
        else if (elementName as NSString).isEqualToString("humedad_relativa")
        {
            sw="H"
        }
        else if (elementName as NSString).isEqualToString("viento")
        {
            sw="V"
        }
    }
    
//-------
// PENDIENTE .... 6 PREGUNTAR POR UN ATRIBUTO QUE NO EXISTE
    func parser(parser: NSXMLParser, foundAttributeDeclarationWithName attributeName: String, forElement elementName: String, type: String?, defaultValue: String?) {
        if (ifDirOK){
            print("\(attributeName)")
        }
        prueba="entra 1"
        if  (elementName as NSString).isEqualToString("prob_precipitacion") ||
            (elementName as NSString).isEqualToString("cota_nieve_prov")    ||
            (elementName as NSString).isEqualToString("estado_cielo")
        {
            prueba="entra"
            if (attributeName as NSString).isEqualToString("periodo") {
                periodo="00-24"
                periodo=defaultValue!
            }
            
            //if (elementName as NSString).isEqualToString("estado_cielo") && (periodo == "00-24") {
            //    cielo_d=attributeDict["descripcion"]!
            //}
        }

    }
//-------
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqualToString("dia") {
            if !fecha.isEqual(nil) {
                elements.setObject(fecha, forKey: "fecha")
            }
            if !lluvia.isEqual(nil) {
                elements.setObject(lluvia, forKey: "lluvia")
            }
            if !nieve.isEqual(nil) {
                elements.setObject(nieve, forKey: "nieve")
            }
            if !cielo.isEqual(nil) {
                elements.setObject(cielo, forKey: "cielo")
            }
            if !cielo_des.isEqual(nil) {
                elements.setObject(cielo_des, forKey: "cielo_des")
            }
            if !v_dir.isEqual(nil) {
                elements.setObject(v_dir, forKey: "v_dir")
            }
            if !v_vel.isEqual(nil) {
                elements.setObject(v_vel, forKey: "v_vel")
            }
            if !t_max.isEqual(nil) {
                elements.setObject(t_max, forKey: "t_max")
            }
            if !t_min.isEqual(nil) {
                elements.setObject(t_min, forKey: "t_min")
            }
            if !h_max.isEqual(nil) {
                elements.setObject(h_max, forKey: "h_max")
            }
            if !h_min.isEqual(nil) {
                elements.setObject(h_min, forKey: "h_min")
            }
            
            posts.addObject(elements)
        }
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String)
    {
        
        
        if element.isEqualToString("prob_precipitacion") && (periodo == "00-24"){
            lluvia.appendString(string)
        } else if element.isEqualToString("cota_nieve_prov") && (periodo == "00-24"){
            nieve.appendString(string)
        } else if element.isEqualToString("estado_cielo") && (periodo == "00-24"){
            cielo.appendString(string)
            cielo_des.appendString(cielo_d)
            cielo_d=""
        } else if element.isEqualToString("direccion") && (sw == "V"){
            v_dir.appendString(string)
        } else if element.isEqualToString("velocidad") && (sw == "V"){
            v_vel.appendString(string)
        } else if element.isEqualToString("maxima") && (sw == "T"){
            t_max.appendString(string)
        } else if element.isEqualToString("minima") && (sw == "T"){
            t_min.appendString(string)
        } else if element.isEqualToString("maxima") && (sw == "H"){
            h_max.appendString(string)
        } else if element.isEqualToString("minima") && (sw == "H"){
            h_min.appendString(string)
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
/*
        //var dias:Array <String> = ["DIA ACTUAL","Jueves 14/01 Lluvia  9º - 2º","1","2","3","4","5","6","7"]
        //cell.titulo.text = dias[indexPath.row]
        //cell.subtitulo.text="Fecha del dia por ejemplo"
        //cell.textLabel?.text=dias[indexPath.row]
        //cell.detailTextLabel?.text = "33333333"
        //cell.imageView?.image=UIImage(named:"Lluvia2.jpg")

        let s_fecha = posts.objectAtIndex(indexPath.row).valueForKey("fecha") as! NSString as String
        let s_lluvia = posts.objectAtIndex(indexPath.row).valueForKey("lluvia") as! NSString as String
        let s_nieve = posts.objectAtIndex(indexPath.row).valueForKey("nieve") as! NSString as String
        let s_cielo = posts.objectAtIndex(indexPath.row).valueForKey("cielo") as! NSString as String
        var s_cielo_des = posts.objectAtIndex(indexPath.row).valueForKey("cielo_des") as! NSString as String
        var s_v_dir = posts.objectAtIndex(indexPath.row).valueForKey("v_dir") as! NSString as String
        var s_v_vel = posts.objectAtIndex(indexPath.row).valueForKey("v_vel") as! NSString as String
        var s_t_max = posts.objectAtIndex(indexPath.row).valueForKey("t_max") as! NSString as String
        var s_t_min = posts.objectAtIndex(indexPath.row).valueForKey("t_min") as! NSString as String
        var s_h_max = posts.objectAtIndex(indexPath.row).valueForKey("h_max") as! NSString as String
        var s_h_min = posts.objectAtIndex(indexPath.row).valueForKey("h_min") as! NSString as String
        
        let a = "Hello"
        let b = "World"
        
        let first = a + ", " + b
        let second = "\(a), \(b)"
*/
        
        if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCellWithIdentifier("MiCelda", forIndexPath: indexPath) as! MiCelda

        cell.titulo.text = posts.objectAtIndex(indexPath.row).valueForKey("cielo_des") as! NSString as String
        cell.subtitulo.text=posts.objectAtIndex(indexPath.row).valueForKey("t_min") as! NSString as String
        cell.subtitulo2.text=posts.objectAtIndex(indexPath.row).valueForKey("h_max") as! NSString as String
        cell.subtitulo3.text=posts.objectAtIndex(indexPath.row).valueForKey("h_min") as! NSString as String

        cell.imagen.image=UIImage(named:iconos_i[0])
        cell.fecha.text=posts.objectAtIndex(indexPath.row).valueForKey("fecha") as! NSString as String
        cell.ciudad.text="Vitoria-Gasteiz"
        cell.estado.text="Basque Country, Spain"
            return cell
        } else {
        let cell = tableView.dequeueReusableCellWithIdentifier("MiCelda2", forIndexPath: indexPath) as! MiCelda2
        
        cell.textLabel?.text = posts.objectAtIndex(indexPath.row).valueForKey("cielo_des") as! NSString as String
        cell.detailTextLabel?.text = posts.objectAtIndex(indexPath.row).valueForKey("fecha") as! NSString as String
        //cell.imageView?.image=UIImage(named:iconos[0])
        //cell.imageView?.image=UIImage(named:"Nube.jpg")
            for (index, value) in iconos_c.enumerate() {
// PENDIENTE .... 4 BUSCAR EN EL array
                if value == posts.objectAtIndex(indexPath.row).valueForKey("cielo") as! NSString as String
                //if value == "14"
                {
                    cell.imageView?.image=UIImage(named:iconos_i[index])
                }
            }

            if indexPath.row == 3 {
                
// PENDIENTE .... 5 UNIR STRINGS EN UN LABEL
                
                let a = ".........................."
                let b : String = posts.objectAtIndex(indexPath.row).valueForKey("cielo") as! NSString as String
                let c = b + ", " + a
                cell.textLabel?.text = "Aqui probamos ......"
                cell.detailTextLabel?.text = "\(a) : \(b)"
            
            }
            return cell
        }
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    if (indexPath.row == 0) {
        return 200; //200
    } else {
        return 60; //60
    }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
