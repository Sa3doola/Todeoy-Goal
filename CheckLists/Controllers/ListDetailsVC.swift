//
//  ListDetailsVC.swift
//  CheckLists
//
//  Created by Saad Sherif on 4/28/21.
//

import UIKit

// MARK: Protocol

protocol ListDetailVCDelegate: class {
    func listDetailVCDidCancel(_ controller: ListDetailsVC)
    func listDetailVC(_ controller: ListDetailsVC, didFinishAdding checklist: Checklist)
    func listDetailVC(_ controller: ListDetailsVC, didFinishEditing checklist: Checklist)
}

class ListDetailsVC: UITableViewController {
    
    // MARK: - Properties
    
    weak var delegate: ListDetailVCDelegate?
    var checklistToEdit: Checklist?
    var iconName = "Folder"

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var iconImage: UIImageView!
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let checklist = checklistToEdit {
            title = "Edit Checklist"
            textField.text = checklist.name
            doneBarButton.isEnabled = true
            iconName = checklist.iconName
        }
        iconImage.image = UIImage(named: iconName)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    // MARK: - Selectors

    @IBAction func cancelTapped() {
        delegate?.listDetailVCDidCancel(self)
    }
    
    @IBAction func doneTapped() {
        if let checklist = checklistToEdit {
            checklist.name = textField.text!
            checklist.iconName = iconName
            delegate?.listDetailVC(self, didFinishEditing: checklist)
        } else {
            let checklist = Checklist(name: textField.text!, iconName: iconName)
            checklist.iconName = iconName
            delegate?.listDetailVC(self, didFinishAdding: checklist)
        }
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath.section == 1 ? indexPath : nil
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PickIcon" {
            let controller = segue.destination as! IconPickerVC
            controller.delegate = self
        }
    }
}

// MARK: - Text Field Delegate

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

// MARK: - Icon Picker Delegate

extension ListDetailsVC: IconPickerVCDelegate {
    
    func iconPicker(_ picker: IconPickerVC, didPick iconName: String) {
        self.iconName = iconName
        iconImage.image = UIImage(named: iconName)
        navigationController?.popViewController(animated: true)
    }
}
