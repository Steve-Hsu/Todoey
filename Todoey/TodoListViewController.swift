//
//  ViewController.swift
//  Todoey
//
//  Created by Steve Hsu on 2018/12/23.
//  Copyright © 2018 Steve Hsu. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{
    
    let itemArray = ["Find mike","Steve","I'm Geralt"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK - Tableview Datasource Methods.
    //The required method to decide number of rows.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return itemArray.count
    }
    //The required method to deicde the spec of cell and the text in the cell.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //the method-1
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoitemCell", for: indexPath)
        //The method-2
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoitemCell")
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK - TableView Delegate Methods
    //The method will send a signal to the delegate(the TableViewController) when user select a cell in tableView.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        //When user select the cell for first time, there will be a checkmark showing up.
        //Use a If method here, let user can cancel the checkmark by select it in second times.
        //If the cell alread have checkmark, then cancel it. or just add a checkmark in the cell.
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        //The method send a signal when user deselect a row.
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

