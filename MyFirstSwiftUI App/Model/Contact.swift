//
//  Contacts.swift
//  MyFirstSwiftUI App
//
//  Created by Unnikrishnan P on 5/5/25.
//
import SwiftUI
import Contacts

struct Contact: Identifiable {
    let id = UUID()
    let name: String
    let phone: String
}
