//
//  ContentView.swift
//  banner
//
//  Created by Jason MacLeod on 11/29/19.
//  Copyright © 2019 Jason MacLeod. All rights reserved.
//

import SwiftUI

struct Banner: Identifiable, Codable {
    var id = UUID()
    var text: String
}

class Banners: ObservableObject {
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

struct ContentView: View {
    @ObservedObject var banners = Banners()
    @State private var showingAddBanner = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(banners.items) { item in
                    Text(item.text)
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iBanner")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingAddBanner = true
                }){
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddBanner) {
                AddView(banners: self.banners)
            }
        }
    }
    func removeItems(at offsets: IndexSet) {
        banners.items.remove(atOffsets: offsets)
    }
    func showItem() {
        ShowView(banners: self.banners)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
