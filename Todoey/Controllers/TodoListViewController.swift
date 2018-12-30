//
//  ViewController.swift
//  Todoey
//
//  Created by Steve Hsu on 2018/12/23.
//  Copyright © 2018 Steve Hsu. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{
    
    var itemArray = [Item]()
    // The fileManager.default is a singleton type method for storing light datas.
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(dataFilePath as Any)
   
        
        //After you shot down the app, the data now will be stored inside the phone.
        //When you execute the app again, we retrieve the datas from the container and put it to the correct custom objects that operating for the app.
        //The container of the datas is “defaults.array”
        //The custom object is “itemArray”
//        //Here we used an optional binding to prevent the app crash when the defaults.array is nil.
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        loadItems()
    }

    //MARK - Tableview Datasource Methods.
    //The required method to decide number of rows.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return itemArray.count
    }
    //The required method to deicde the spec of cell and the text in the cell.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //the method-1
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoitemCell", for: indexPath)
        //The method-2
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoitemCell")
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Here is a switch, if the property of itemArray[].done is true then displaying a checkmark.
        //The code is a type of advanced if statement. if the item.done is true, the value would be .checkmark, otherwise, it would be .none.
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    //The method will send a signal to the delegate(the TableViewController) when user select a cell in tableView.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
       //Here as a switch to decide the itemArray.done is true or false that is used as a signal in other method to deicde if cell display a checkmark or not.
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        //The method display a animation when user deselect a row.
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textFiled = UITextField()
        
        //Show up a Alert.
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        //Completion handler, define spec of the button on the Alert and what will happen after you pressed it.
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen once the user clicks the Add Item button on our UIAlert
            
            //To add a new member to array the "itemArray", by deriving the sring from alertTextFiled. i.e. the user type in a data in the TexiFiled in a alert.
            let newItem = Item()
            newItem.title = textFiled.text!
            self.itemArray.append(newItem)
            
            self.saveItems()
        }
        
        
        alert.addTextField { (alertTextFiled) in
            alertTextFiled.placeholder = "Create new item"
            textFiled = alertTextFiled
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }
    
    
    //MARK - Model Manupulation methods.
    //The method is to grab data and save it in the data container of tha app.
    func saveItems() {
        // the encoder here is a plist type data. it will be used to grab our custom plist datas.
        let encoder = PropertyListEncoder()
        
        //The method is to grab data and save it in the data container of tha app.
        do {
            // The object "data" execute to grab and encode the datas. the data source here is the itemArray.
            let data = try encoder.encode(itemArray)
            
            // It designate where sould the data to be saved. here we designate it sould be saved in as the url in the dataFilePath.
            try data.write(to: dataFilePath!)
            
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        //The method is to update the TableView since we append a new String to the itemArry, that will also let the method "numberOfRowsInSection" add a new cells in the tableView, so we need to reload to update the TableView.
        self.tableView.reloadData()
    }
    
    
    // The method is to derieve datas from the memoris.
    func loadItems() {
        // as we save the data and encode it. we to decode it before we derieve it back.
       if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
        }
    }
}

