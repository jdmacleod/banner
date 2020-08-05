//
//  EditView.swift
//  banner
//
//  Created by Jason MacLeod on 11/30/19.
//  Copyright © 2019 Jason MacLeod. All rights reserved.
//

import SwiftUI

struct EditView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var banners: Banners
    @State private var text = ""
    
    
    //banners.items[selectedIndex].text
    
    var body: some View {
        //let selectedIndex = banners.items.firstIndex(where: {$0.id == banners.selectedUUID})

        NavigationView {
            Form {
                TextField(banners.items[banners.items.firstIndex(where: {$0.id == banners.selectedUUID}) ?? 0].text, text: $text)
            }
            .navigationBarTitle(Text("Edit Banner"), displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                self.presentationMode.wrappedValue.dismiss()
                }, trailing: Button("Save") {
                    self.banners.items[self.banners.items.firstIndex(where: {$0.id == self.banners.selectedUUID}) ?? 0].text = self.text.trimmingCharacters(in: .whitespacesAndNewlines)
                    self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(banners: Banners())
    }
}
