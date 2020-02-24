//
//  CatagoryViewController.swift
//  Todoey
//
//  Created by Muhammet Taha Genc on 11.12.2018.
//  Copyright © 2018 Muhammet Taha Genc. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CatagoryViewController: SwipeTableTableViewController {
    
    let realm = try! Realm()
    
    var categoryArray: Results<Category>?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadCategories()
        tableView.separatorStyle = .none
    }

    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let colorN = categoryArray?[indexPath.row].colorName ?? "1D9BF6"
        let color = HexColor(colorN)
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories Added yet."
        cell.backgroundColor = color
        cell.textLabel?.textColor = ContrastColorOf(color!, returnFlat: true)
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
    
    //MARK: - Data Manuipulation Methods
    
    func save (category: Category) {
        
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
         print("Error while saving data \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories() {
        
        categoryArray = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    //MARK - Delete Categories
    
    override func updateModel(at indexPath: IndexPath) {
        
        if let CategoryForDeletion = self.categoryArray?[indexPath.row] {
            do{
                try self.realm.write {
                    self.realm.delete(CategoryForDeletion)
                }
            }catch{
                print("Error while saving data \(error)")
            }
        }

    }
    


    
    //MARK: - Add New Categories
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            //what will happen when the user clicks the ADD Item button on our UIAlert
            
            if textField.text == "" {
                
                let errorAlert = UIAlertController(title: "Error", message: "A category can not be empty", preferredStyle: .alert)
                
                errorAlert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { _ in
                    NSLog("")
                }))
                
                self.present(errorAlert, animated: true, completion: nil)
                
            } else {
                
                let newCategory = Category()
                newCategory.name = textField.text!
                newCategory.colorName = UIColor.randomFlat.hexValue()
                self.save(category: newCategory)
                
            }
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)

    }
    
}

