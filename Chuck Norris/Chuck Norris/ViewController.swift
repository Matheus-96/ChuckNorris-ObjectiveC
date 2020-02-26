//
//  ViewController.swift
//  Chuck Norris
//
//  Created by Maria Luiza Carvalho Sperotto on 13/11/19.
//  Copyright © 2019 Maria Luiza Carvalho Sperotto. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var jokes = [Joke]()
    var selectedCategory: String = ""
    var categorias = [String]()
    
    @IBAction func shuffle(_ sender: Any) {
        categorias.shuffle()
        self.tableView.reloadData()
        
        
    }
    
    @IBAction func reload(_ sender: Any) {
        categorias.sort()
        self.tableView.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = "Choose a category"
        parse()
        
    }
    
    func parse() {
        let urlString = "https://api.chucknorris.io/jokes/categories"
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                self.categorias = json as! [String]
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }.resume()
        
    }
    
    
    
    // Table functions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorias.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Category", for: indexPath)
        let category = categorias[indexPath.row]
        cell.textLabel?.text = category
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categorias[indexPath.row]
        selectedCategory = category
        performSegue(withIdentifier: "Detail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            let categoryDetail = segue.destination as! DetailViewController
            categoryDetail.selectedCategory = selectedCategory
        }
    }
    
}



