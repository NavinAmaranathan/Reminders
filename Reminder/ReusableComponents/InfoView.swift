//
//  InfoView.swift
//  Reminder
//
//  Created by Navi on 12/07/22.
//

import Foundation
import UIKit

protocol InfoViewProvider {
    func display(title: String, message: String,
                 actionTitle: String,
                 action: ((UIAlertAction) -> Void)?,
                 style: UIAlertController.Style,
                 target: UIViewController)
}

final class InfoView: InfoViewProvider {
    
    static let shared  = InfoView()
    private init() {}
    
    /// Use to display alert/ action sheet based on requirement.
    /// - Parameters:
    ///   - title: title text
    ///   - message: subtitle message
    ///   - actionTitle: action button title
    ///   - action: action handler
    ///   - style: UIAlertController style to select
    ///   - target: Display VC
    func display(title: String, message: String,
                 actionTitle: String,
                 action: ((UIAlertAction) -> Void)? = nil,
                 style: UIAlertController.Style,
                 target: UIViewController) {
        let infoView = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: style)
        infoView.addAction(UIAlertAction(title: actionTitle,
                                      style: .default,
                                        handler: action))
        target.present(infoView, animated: true, completion: nil)
    }
}
