//
//  Person.swift
//  ContactList
//
//  Created by Даниил Чупин on 28.05.2023.
//

import Foundation

struct Person {
    let firstName: String
    let lastName: String
    let email: String
    let phoneNumber: String
}

class DataManager {
    var firstNames: [String] = []
    var lastNames: [String] = []
    var emails: [String] = []
    var phoneNumbers: [String] = []

    func generateRandomPerson() -> Person? {
        guard !firstNames.isEmpty, !lastNames.isEmpty else {
            return nil
        }

        let firstName = uniqueRandomElement(from: &firstNames)
        let lastName = uniqueRandomElement(from: &lastNames)
        let email = generateUniqueEmail(firstName: firstName,
                                        lastName: lastName)
        let phoneNumber = generateUniquePhoneNumber()
        
        return Person(firstName: firstName,
                      lastName: lastName,
                      email: email,
                      phoneNumber: phoneNumber)
    }

    private func uniqueRandomElement(from array: inout [String]) -> String {
        let randomIndex = Int.random(in: 0..<array.count)
        let element = array[randomIndex]
        array.remove(at: randomIndex)
        
        return element
    }

    private func generateUniqueEmail(firstName: String,
                                     lastName: String)-> String {
        let formattedFirstName = firstName.lowercased()
        let formattedLastName = lastName.lowercased()
        
        return "\(formattedFirstName).\(formattedLastName)@example.com"
    }

    private func generateUniquePhoneNumber() -> String {
        var phoneNumber = ""
        var counter = 1
        repeat {
            phoneNumber = "+7\(generateRandomNumber())\(counter)"
            counter += 1
        } while phoneNumbers.contains(phoneNumber)
        phoneNumbers.append(phoneNumber)
        
        return phoneNumber
    }

    private func generateRandomNumber() -> String {
        let randomNumber = String(format: "%09d",
                                  arc4random_uniform(1_000_000_000))
        
        return randomNumber
    }
}
