//
//  ViewController.swift
//  NamesCompApp
//
//  Created by Кирилл Бережной on 16.10.2022.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var yourNameTF: UITextField!
    @IBOutlet weak var partnersNameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func backButtonTapped(_ sender: UIButton) {
    }
    // connect second ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ResultViewController else { return }
        destinationVC.firstName = yourNameTF.text // change text
        destinationVC.secondName = partnersNameTF.text
        
    }
    
    // resultButtonTapped with condition
    @IBAction func resultButtonTapped() {
        guard let firstName = yourNameTF.text, let secondName = partnersNameTF.text else { return }
        if firstName.isEmpty || secondName.isEmpty {
            showAlert(title: "Names are missing!",
                     message: "Please enter both names 😡🖕🏻"
            )
            return
        }
        
        performSegue(withIdentifier: "goToResult", sender: nil)
    }
    
    @IBAction func unwindSegueToFirstVC(segue: UIStoryboardSegue) {
        //guard segue.identifier == "undwindSegue" else { return }
        
        yourNameTF.text = ""
        partnersNameTF.text = ""
    }
    
    
}
//input processing

extension FirstViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// hide keyboard when we text
extension FirstViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    //method to move to the next line
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == yourNameTF {
            partnersNameTF.becomeFirstResponder()
        } else {
            resultButtonTapped()
        }
        return true
    }

}
