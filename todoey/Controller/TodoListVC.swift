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
    //    var defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
    loadItems()
    
        
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
        
        saveItems()
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
            
            
            self.saveItems()
            
            //            self.defaults.set(self.itemArray, forKey: "ToDoeyItems")
            
            
        }
        
        
        alert.addTextField { (TextField) in
            TextField.placeholder = "Add New Item"
            textField = TextField
            
        }
        
        
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    // MARk - Model Manupolation Methods
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }
        catch {
            print("error Encoding Items\(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray =  try! decoder.decode([Item].self, from: data)
            }
            catch {
                print("Error to decode item Array")
            }
       
            tableView.reloadData()
        
        }
        
    }
    
    
}
