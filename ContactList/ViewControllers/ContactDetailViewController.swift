//
//  ContactDetailViewController.swift
//  ContactList
//
//  Created by Даниил Чупин on 28.05.2023.
//

import UIKit

final class ContactDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!

    var person: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let person = person {
            nameLabel.text = "\(person.firstName) \(person.lastName)"
            emailLabel.text = person.email
            phoneLabel.text = person.phoneNumber
        }
    }
}
