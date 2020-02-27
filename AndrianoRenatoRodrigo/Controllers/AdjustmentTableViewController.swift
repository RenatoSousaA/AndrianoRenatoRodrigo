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
    @IBOutlet weak var tvDolar: UITextField!
    @IBOutlet weak var tvIof: UITextField!
    
    var statesManager = StatesManager.shared
    var config = Configuration.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        loadStates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        valuesDefaults()
    }
    
    func valuesDefaults() {
        tvDolar.text = "\(config.dolar)"
        tvIof.text = "\(config.iof)"
    }
    
    func loadStates() {
        statesManager.loadStates(with: context)
        tableView.reloadData()
    }
    
    @IBAction func addState(_ sender: UIButton) {
        showAlert(with: nil)
    }
    
    @IBAction func changeDolar(_ sender: UITextField) {
        config.dolar = Double(sender.text!) ?? 0
    }
    
    @IBAction func changeIof(_ sender: UITextField) {
        config.iof = Double(sender.text!) ?? 0
    }
    
    func showAlert(with state: States?) {
        let title = state == nil ? "Adicionar" : "Editar"
        let alert = UIAlertController(title: title + " Estado", message: nil, preferredStyle: .alert)
        
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
        return statesManager.states.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let state = statesManager.states[indexPath.row]
        showAlert(with: state)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            statesManager.deleteState(index: indexPath.row, context: context)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
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
