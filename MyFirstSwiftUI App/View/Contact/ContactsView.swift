//
//  ContactsView.swift
//  MyFirstSwiftUI App
//
//  Created by Unnikrishnan P on 5/5/25.
//
import SwiftUI
import Contacts

struct ContactsView: View {
    @State private var contacts: [Contact] = []
    @State private var searchText: String = ""

    var filteredContacts: [Contact] {
        if searchText.isEmpty {
            return contacts
        } else {
            return contacts.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.phone.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationView {
            List(filteredContacts) { contact in
                VStack(alignment: .leading) {
                    Text(contact.name).font(.headline)
                    Text(contact.phone).font(.subheadline).foregroundColor(.gray)
                }
            }
            .searchable(text: $searchText, prompt: "Search contacts")
            .navigationTitle("My Contacts")
            .onAppear(perform: fetchContacts)
        }
    }

    func fetchContacts() {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { granted, error in
            guard granted else {
                print("Access denied or error: \(error?.localizedDescription ?? "Unknown")")
                return
            }

            DispatchQueue.global(qos: .userInitiated).async {
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
                let request = CNContactFetchRequest(keysToFetch: keys)
                var results: [Contact] = []

                do {
                    try store.enumerateContacts(with: request) { (cnContact, _) in
                        let name = "\(cnContact.givenName) \(cnContact.familyName)"
                        let phone = cnContact.phoneNumbers.first?.value.stringValue ?? ""
                        results.append(Contact(name: name, phone: phone))
                    }

                    // Update UI on main thread
                    DispatchQueue.main.async {
                        self.contacts = results
                    }

                } catch {
                    print("Failed to fetch contacts: \(error)")
                }
            }
        }
    }
}
