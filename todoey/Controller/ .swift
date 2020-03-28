//
//  CateguryViewController.swift
//  todoey
//
//  Created by JavadFaghih on 1/7/1399 AP.
//  Copyright © 1399 AP JavadFaghih. All rights reserved.
//

import UIKit
import CoreData


class CateguryViewController: UITableViewController {
    
    
    var categuryArray = [Categury]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadCateguries()
        
        
    }
    
    
    //MARK: - TableViewDataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categuryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CateguryCell", for: indexPath)
        
        cell.textLabel?.text = categuryArray[indexPath.row].name
        
        return cell
        
    }
    
    
    //MARK: - TableViewDelegate Methods

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        performSegue(withIdentifier: "goToItems", sender: self)
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
            
            let destinationVC = segue.destination as! TodoListVC
            
            if   let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = categuryArray[indexPath.row]
            }
            
            
        
        
        
    }
    
    
    
    
    //MARK: - DataManipulation Methods
    
    func saveCateguries() {
        do {
        try context.save()
        }
        catch {
            print(" error Saving Categury\(error)")
        }
        
        tableView.reloadData()
        
        
    }
    
    func loadCateguries() {
        
        let request: NSFetchRequest<Categury> = Categury.fetchRequest()
        do {
            categuryArray = try context.fetch(request)
        }
        catch {
            print("error loading categories\(error)")
        }
        
        tableView.reloadData()
        
    }
    
    
    
    
    
    //MARK: - AddNewCateguries Methods
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Categury", message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Add Item", style: .default) {
            (action) in
            
            let newCategury = Categury(context: self.context)
            newCategury.name = textField.text!
            
            self.categuryArray.append(newCategury)
            
            self.saveCateguries()
            
            
            
        }
        
        alert.addAction(alertAction)
        alert.addTextField { (TextField) in
            TextField.placeholder = "Add a new categury"
            textField = TextField
        }
        present(alert, animated: true, completion: nil)
        
    }
    
}
