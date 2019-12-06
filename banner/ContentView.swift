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
    @State private var modalView = false
    @State private var showingEditBanner = false
    @Environment(\.editMode) var editMode
    
    var body: some View {
        NavigationView {
            List {
                ForEach(banners.items) { item in
                    NavigationLink(destination: DetailView(banner: item)
                    ) {
                        Text(item.text)
                    }
                }
                .onDelete(perform: removeItems)
                .onMove(perform: moveItems)
            }
            .navigationBarTitle("iBanner")
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.modalView = true
                }){
                    Image(systemName: "plus")
                        .padding()
                }
            )
        }
        .sheet(isPresented: $modalView) {
            if self.editMode?.wrappedValue == .inactive {
                AddView(banners: self.banners)
            }
            if self.editMode?.wrappedValue == .active {
                EditView(banners: self.banners)
            }
        }
    }
    func removeItems(at offsets: IndexSet) {
        banners.items.remove(atOffsets: offsets)
    }
    func moveItems(from source: IndexSet, to destination: Int) {
        banners.items.move(fromOffsets: source, toOffset: destination)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
