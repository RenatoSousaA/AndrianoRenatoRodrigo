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
    @IBOutlet weak var sbCard: UISwitch!
    
    var statesManager = StatesManager.shared
    var config = Configuration.shared
    
    var cart: Cart!
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white
        return pickerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        toolbar.tintColor = UIColor(named: "main")
        
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let btDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        let btSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [btCancel, btSpace, btDone]
        
        tfState.inputView = pickerView
        tfState.inputAccessoryView = toolbar
    }
    
    @objc func cancel() {
        tfState.resignFirstResponder()
    }
    
    @objc func done() {
        tfState.text = statesManager.states[pickerView.selectedRow(inComponent: 0)].name
        cancel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statesManager.loadStates(with: context )
        loadProduct()
    }
    
    func loadProduct() {
        if cart != nil {
            tfName.text = cart.name
            tfPrice.text = "\(cart.price)"
            sbCard.setOn(cart.isCard, animated: true)
            let state = cart.states
//            print(statesManager.states)
//            print(state)
//            if let stateSelected = state, let index = statesManager.states.index(of: stateSelected) {
//                pickerView.selectedRow(inComponent: index)
//            }
            
            if let image = cart.imgProduct as? UIImage {
                ivProduct.image = image
            } else {
                ivProduct.image = UIImage(named: "imgProdutos")
            }
            
            btImg.setTitle("Clique para alterar a imagem.", for: .normal)
            title = "Alterar produto"
            btAddEdit.setTitle("ALTERAR", for: .normal)
        }
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
        let alert = UIAlertController(title: "Selecionar imagem", message: "De onde quer escolher a imagem?", preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Câmera", style: .default, handler: { (action: UIAlertAction) in
                self.selectPicture(sourceType: .camera)
            })
            alert.addAction(cameraAction)
        }
        
        let libraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default) { (action: UIAlertAction) in
            self.selectPicture(sourceType: .photoLibrary)
        }
        alert.addAction(libraryAction)
        
        let photosAction = UIAlertAction(title: "Álbum de fotos", style: .default) { (action: UIAlertAction) in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        }
        alert.addAction(photosAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func selectPicture(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        imagePicker.navigationBar.tintColor = UIColor(named: "main")
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func AddEditProduct(_ sender: UIButton) {
        if cart == nil {
            cart = Cart(context: context)
        }
        
        let priceUS = Double(tfPrice.text!) ?? 0
        let priceRS = Double(priceUS * config.dolar)
        
        cart.name = tfName.text
        cart.price = priceUS
        cart.priceRS = priceRS
        cart.imgProduct = ivProduct.image
        cart.isCard = sbCard.isOn
        
        if !tfState.text!.isEmpty {
            cart.states = statesManager.states[pickerView.selectedRow(inComponent: 0)]
        }
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
}

extension RegisterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return statesManager.states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let state = statesManager.states[row]
        return state.name ?? ""
    }
}

extension RegisterViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Erro: \(info)")
        }
        ivProduct.image = image
        btImg.setTitle(nil, for: .normal)
        btImg.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        dismiss(animated: true, completion: nil)
    }
}
