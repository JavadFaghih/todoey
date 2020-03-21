//
//  ViewController.swift
//  todoey
//
//  Created by JavadFaghih on 1/1/1399 AP.
//  Copyright © 1399 JavadFaghih. All rights reserved.
//

import UIKit

class TodoListVC: UITableViewController   {

    
    
    
    
    var itemArray = [Item]()
  
    
    var defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
  
        var newItem = Item()
        newItem.title = "find Mike"
        itemArray.append(newItem)
        
        var newItem2 = Item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)
        
        var newItem3 = Item()
        newItem3.title = "Destory Demorgon"
        itemArray.append(newItem3)
        
        
        
        if let value = defaults.array(forKey: "ToDoeyItems") as? [Item] {
            itemArray = value
        }
    
    }

    // MARK - TableView DataSourceMethods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
        print("cell for row at indexpath called")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
      
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    // MARK - TableView Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
  
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new ToDoEy Items", message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Add Item", style: .default) {
           (action) in
          
            let newItem = Item()
            newItem.title = textField.text!
            
                self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "ToDoeyItems")
                self.tableView.reloadData()
           
                }
         
        
        alert.addTextField { (TextField) in
            TextField.placeholder = "Add New Item"
            textField = TextField

        }
        
        
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
        
    }
    
}
