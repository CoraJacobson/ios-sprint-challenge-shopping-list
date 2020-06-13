//
//  ShoppingItemController.swift
//  Shopping List
//
//  Created by Cora Jacobson on 6/13/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ShoppingItemController {
    
    init() {
        loadFromPersistentStore()
        for item in itemNames {
            if shoppingItems.isEmpty {
                shoppingItems.append(ShoppingItem(name: item, addedToList: false, imageName: item))
            }
        }
    }
    
    var shoppingItems: [ShoppingItem] = []
    
    let itemNames = ["Apple", "Grapes", "Milk", "Muffin", "Popcorn", "Soda", "Strawberries"]
    
    // MARK: Persistence
    
    private var ShoppingListURL: URL? {
        let fm = FileManager.default
        let filename = "ShoppingList.plist"
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return dir.appendingPathComponent(filename)
    }
    
    private func saveToPersistentStore() {
        guard let url = ShoppingListURL else { return }
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(shoppingItems)
            try data.write(to: url)
        } catch {
            NSLog("Was not able to encode data: \(error)")
        }
    }
    
    private func loadFromPersistentStore() {
        let fm = FileManager.default
        guard let url = ShoppingListURL,
        fm.fileExists(atPath: url.path) else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedShoppingItems = try decoder.decode([ShoppingItem].self, from: data)
            shoppingItems = decodedShoppingItems
        } catch {
            NSLog("No data was saved: \(error)")
        }
    }
    
}