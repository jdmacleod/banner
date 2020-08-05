//
//  Banner.swift
//  banner
//
//  Created by Jason MacLeod on 8/4/20.
//  Copyright © 2020 Jason MacLeod. All rights reserved.
//

import Foundation

struct Banner: Identifiable, Codable {
    var id = UUID()
    var text: String
}

class Banners: ObservableObject {
    @Published var selectedUUID: UUID
    @Published var items = [Banner]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try?
                encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init() {
        self.selectedUUID = UUID()
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            
            if let decoded = try?
                decoder.decode([Banner].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}
