//
//  AddReminderViewController+TextField.swift
//  Reminder
//
//  Created by Navi on 11/07/22.
//

import UIKit

extension AddReminderViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
