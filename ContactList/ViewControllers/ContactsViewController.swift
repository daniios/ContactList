//
//  ContactsViewController.swift
//  ContactList
//
//  Created by Даниил Чупин on 29.05.2023.
//

import UIKit

final class ContactsViewController: UIViewController, UITableViewDataSource,
                              UITableViewDelegate {
    
    private var tableView: UITableView!
    var people: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setContactsTableView()
    }

    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                 for: indexPath)

        let person = people[indexPath.section]

        if indexPath.row == 0 {
            cell.imageView?.image = UIImage(systemName: "envelope")
            cell.textLabel?.text = person.email
        } else {
            cell.imageView?.image = UIImage(systemName: "phone")
            cell.textLabel?.text = person.phoneNumber
        }
        return cell
    }

    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        let person = people[section]
        return "\(person.firstName) \(person.lastName)"
    }
    
    // MARK: - Private methods
    private func setContactsTableView() {
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
    }
}
