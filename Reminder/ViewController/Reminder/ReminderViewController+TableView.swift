//
//  ReminderViewController+TableView.swift
//  Reminder
//
//  Created by Navi on 11/07/22.
//

import UIKit

extension ReminderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let title = reminders?[indexPath.row].title, let body = reminders?[indexPath.row].subtitle else {
            return
        }
        InfoView.shared.display(title: title, message: body, actionTitle: "Ok", action: nil, style: .actionSheet, target: self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            if let item = reminders?[indexPath.row] {
                if manager.deleteReminder(reminder: item) == true {
                    tableView.beginUpdates()
                    reminders?.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    tableView.endUpdates()
                }
            }
        }
    }
}

extension ReminderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = reminders?[indexPath.row].title ?? ""
        cell.detailTextLabel?.text = reminders?[indexPath.row].subtitle ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
