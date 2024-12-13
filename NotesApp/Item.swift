//
//  Item.swift
//  NotesApp
//
//  Created by Rassul Bessimbekov on 13.12.2024.
//

import Foundation
import SwiftData

// @Model is similar to how you might use TypeScript interfaces or Mongoose schemas
// It automatically provides persistence (like MongoDB/localStorage) and reactivity (like React state)
@Model
final class Note {
    // These properties are like state in React components
    // They automatically trigger UI updates when changed
    var title: String
    var content: String
    var creationDate: Date
    var modificationDate: Date
    
    // Constructor (similar to JavaScript class constructor)
    // Default parameters work like JavaScript's default function parameters
    init(title: String = "", content: String = "") {
        self.title = title
        self.content = content
        // Date() works the same way as JavaScript's new Date()
        self.creationDate = Date()
        self.modificationDate = Date()
    }
}
