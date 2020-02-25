//
//  RegisterViewController.swift
//  AndrianoRenatoRodrigo
//
//  Created by Renato Sousa on 24/02/20.
//  Copyright © 2020 Renato Sousa. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var ivProduct: UIImageView!
    @IBOutlet weak var tfState: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var btAddEdit: UIButton!
    @IBOutlet weak var btImg: UIButton!
    
    var cart: Cart!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func addEditImgProduct(_ sender: UIButton) {
    }
    
    @IBAction func AddEditProduct(_ sender: UIButton) {
        if cart == nil {
            cart = Cart(context: context)
        }
        
        cart.name = tfName.text
        cart.price = 22.2
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
}
