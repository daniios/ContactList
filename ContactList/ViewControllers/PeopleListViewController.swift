//
//  ViewController.swift
//  ContactList
//
//  Created by Даниил Чупин on 28.05.2023.
//

import UIKit

final class PeopleListViewController: UIViewController, UITableViewDataSource,
                                UITableViewDelegate {
    
    // MARK: - Private properties
    private var tableView: UITableView!
    private var people: [Person] = []
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableViewSettings()
        setPersons()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContactDetailViewController" {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let person = people[indexPath.row]
                    if let contactDetailVC = segue.destination as?
                        ContactDetailViewController {
                        contactDetailVC.person = person
                    }
                }
        }
        
        guard let viewControllers = tabBarController?.viewControllers
        else { return }
        
        for viewController in viewControllers {
            if let contactsVC = viewController as? ContactsViewController {
                contactsVC.people = people
            }
        }
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                 for: indexPath)
        let person = people[indexPath.row]
        cell.textLabel?.text = "\(person.firstName) \(person.lastName)"
        return cell
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        _ = people[indexPath.row]
        performSegue(withIdentifier: "ContactDetailViewController", sender: nil)
    }
    
    // MARK: - Private methods
    private func showContactDetail(for person: Person) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let contactDetailVC =
            storyboard.instantiateViewController(withIdentifier:
                                            "ContactDetailViewController") as?
                                                ContactDetailViewController {
            contactDetailVC.person = person
            navigationController?.pushViewController(contactDetailVC,
                                                     animated: true)
        }
    }
    
    private func setTableViewSettings() {
        tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        // Настройка tableView - чтобы на TabBar не накладывалась tableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:
                        view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo:
                        view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo:
                        view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:
                        view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setPersons() {
        // Заполняем список людей
        let dataManager = DataManager()
        dataManager.firstNames = ["Emily", "Liam", "Olivia", "Noah", "Ava",
                                  "Isabella", "Sophia", "Mia", "Charlotte",
                                  "Amelia", "Harper", "Evelyn", "Abigail",
                                  "Emily", "Ella", "Elizabeth", "Camila",
                                  "Luna", "Sofia", "Victoria"]
        dataManager.lastNames = ["Johnson", "Smith", "Williams", "Brown",
                                 "Jones", "Davis", "Miller", "Wilson",
                                 "Anderson", "Taylor", "Clark", "Thompson",
                                 "Harris", "Lewis", "Turner",
                                 "Martin", "Walker", "White", "Moore", "Lee"]
        
        for _ in 1...20 {
            if let person = dataManager.generateRandomPerson() {
                people.append(person)
            }
        }
    }
}
