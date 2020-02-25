//
//  AdjustmentTableViewController.swift
//  AndrianoRenatoRodrigo
//
//  Created by Renato Sousa on 25/02/20.
//  Copyright © 2020 Renato Sousa. All rights reserved.
//

import UIKit

class AdjustmentTableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var statesManager = StatesManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        loadStates()
    }
    
    func loadStates() {
        statesManager.loadStates(with: context)
        tableView.reloadData()
    }
    
    @IBAction func addState(_ sender: UIButton) {
        showAlert(with: nil)
    }
    
    func showAlert(with state: States?) {
        let title = state == nil ? "Adicionar" : "Editar"
        let alert = UIAlertController(title: title + "Estado", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textFieldState) in
            textFieldState.placeholder = "Nome do Estado"
            if let name = state?.name {
                textFieldState.text = name
            }
        }
        
        alert.addTextField { (textFieldTax) in
            textFieldTax.placeholder = "Taxa do Estado"
            if let tax = state?.tax {
                textFieldTax.text = "\(tax)"
            }
        }
        
        alert.addAction(UIAlertAction(title: title, style: .default, handler: { (action) in
            let state = state ?? States(context: self.context)
            state.name = alert.textFields?.first?.text
            state.tax = Double(alert.textFields![1].text!) ?? 0
            
            do {
                try self.context.save()
                self.loadStates()
            } catch {
                print(error.localizedDescription)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}

extension AdjustmentTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return statesManager.states.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let state = statesManager.states[indexPath.row]
        cell.textLabel?.text = state.name
        cell.detailTextLabel?.text = "\(state.tax)"

        return cell
    }
}

extension AdjustmentTableViewController: UITableViewDelegate {
    
}
