//
//  ViewController.swift
//  todoey
//
//  Created by JavadFaghih on 1/1/1399 AP.
//  Copyright © 1399 JavadFaghih. All rights reserved.
//

import UIKit

class TodoListVC: UITableViewController   {

    var itemArray = ["Find Mike", "Buy Eggos", "Destory Demogorgon"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK - TableView DataSourceMethods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    // MARK - TableView Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        

        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
  
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new ToDoEy Items", message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Add Item", style: .default) {
           (action) in
          
                self.itemArray.append(textField.text!)
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
