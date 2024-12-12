//
//  Item.swift
//  NotesApp
//
//  Created by Rassul Bessimbekov on 13.12.2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
