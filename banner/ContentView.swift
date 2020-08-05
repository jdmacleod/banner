//
//  ContentView.swift
//  banner
//
//  Created by Jason MacLeod on 11/29/19.
//  Copyright © 2019 Jason MacLeod. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var banners = Banners()
    @State private var modalView = false
    @State private var showingEditBanner = false
    @Environment(\.editMode) var editMode
    @State var isEditMode: EditMode = .inactive
    @State var bannerSelection: Banner.ID? = nil
    
    var body: some View {
        NavigationView {
            List {
                ForEach(banners.items) { item in
                    NavigationLink(destination: DetailView(banner: item)
                    ) {
                        Text(item.text)
                    }
                    .onTapGesture(perform: {if (self.isEditMode == .active) {self.banners.selectedUUID = item.id
                        self.bannerSelection = item.id
                        self.modalView = true}})
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
                    .resizable()
                        .scaleEffect(1.3)
                }
                .opacity((self.isEditMode == .inactive) ? 1 : 0)
            )
                .environment(\.editMode, self.$isEditMode)
        }
        .sheet(isPresented: $modalView) {
            if self.isEditMode == .inactive {
                AddView(banners: self.banners)
            }
            if self.isEditMode == .active {
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
