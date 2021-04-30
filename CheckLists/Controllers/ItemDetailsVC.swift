//
//  ItemDetailsVC.swift
//  CheckLists
//
//  Created by Saad Sherif on 4/26/21.
//

import UIKit

protocol ItemDetailsVCDelegate: class {
    func itemDetailVCDidCancel(_ controller: ItemDetailsVC)
    func itemDetailVC(_ controller: ItemDetailsVC, didFinishAdding item: CheckListItem)
    func itemDetailVCDidCancel(_ controller: ItemDetailsVC, didFinishEditing item: CheckListItem)
}

class ItemDetailsVC: UITableViewController {

    // MARK: - Properites
    
    weak var delegate: ItemDetailsVCDelegate?
    var itemToEdit: CheckListItem?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let itemToEdit = itemToEdit {
            title = "Edit Item"
            textField.text = itemToEdit.text
            doneBarButton.isEnabled = true
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    // MARK: - Helper Functions
    
    // MARK: - Selectors
    
    @IBAction func cancelTapped() {
        delegate?.itemDetailVCDidCancel(self)
    }
    
    @IBAction func doneTapped() {
        if let item = itemToEdit {
            item.text = textField.text!
            delegate?.itemDetailVCDidCancel(self, didFinishEditing: item)
        } else {
            let item = CheckListItem(text: textField.text!)
            delegate?.itemDetailVC(self, didFinishAdding: item)
        }
    }

    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}

extension ItemDetailsVC: UITextFieldDelegate {
    
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
