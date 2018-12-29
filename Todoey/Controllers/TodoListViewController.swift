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
    
    //The datas container.
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //After you shot down the app, the data now will be stored inside the phone.
        //When you execute the app again, we retrieve the datas from the container and put it to the correct custom objects that operating for the app.
        //The container of the datas is “defaults.array”
        //The custom object is “itemArray”
        //Here we used an optional binding to prevent the app crash when the defaults.array is nil.
//        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
//            itemArray = items
//        }
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
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

        tableView.reloadData()
        
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
            //To add a new member to the allary of itemArray, by deriving the sring from alertTextFiled. i.e. the user type in a data in the TexiFiled in a alert.
            let newItem = Item()
            newItem.title = textFiled.text!
            self.itemArray.append(newItem)
            
            //The method is to grab data and save it in the data container of tha app.
            //In here we grab datas from object, the "itemArray", and we give the container a name "TodoListArray"
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
          //The method is to update the TableView since we append a new String to the itemArry, that will also let the method "numberOfRowsInSection" add a new cells in the tableView, so we need to reload to update the TableView.
            self.tableView.reloadData()
        }
        
        
        alert.addTextField { (alertTextFiled) in
            alertTextFiled.placeholder = "Create new item"
            textFiled = alertTextFiled
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }
    
    
    
}

