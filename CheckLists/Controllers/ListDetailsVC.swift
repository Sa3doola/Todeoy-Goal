//
//  ListDetailsVC.swift
//  CheckLists
//
//  Created by Saad Sherif on 4/28/21.
//

import UIKit

protocol ListDetailVCDelegate: class {
    func listDetailVCDidCancel(_ controller: ListDetailsVC)
    func listDetailVC(_ controller: ListDetailsVC, didFinishAdding checklist: Checklist)
    func listDetailVC(_ controller: ListDetailsVC, didFinishEditing checklist: Checklist)
}

class ListDetailsVC: UITableViewController {
    
    weak var delegate: ListDetailVCDelegate?
    var checklistToEdit: Checklist?

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let checklist = checklistToEdit {
            title = "Edit Checklist"
            textField.text = checklist.name
            doneBarButton.isEnabled = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }

    @IBAction func cancelTapped() {
        delegate?.listDetailVCDidCancel(self)
    }
    
    @IBAction func doneTapped() {
        if let checklist = checklistToEdit {
            checklist.name = textField.text!
            delegate?.listDetailVC(self, didFinishEditing: checklist)
        } else {
            let checklist = Checklist(name: textField.text!)
            delegate?.listDetailVC(self, didFinishAdding: checklist)
        }
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}

extension ListDetailsVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        doneBarButton.isEnabled = !newText.isEmpty
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneBarButton.isEnabled = false
        return true
    }
}
