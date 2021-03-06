//
//  AddView.swift
//  banner
//
//  Created by Jason MacLeod on 11/29/19.
//  Copyright © 2019 Jason MacLeod. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var banners: Banners
    @State private var text = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Type text here.", text: $text)
            }
            .navigationBarTitle(Text("Add Banner"), displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                self.presentationMode.wrappedValue.dismiss()
                }, trailing: Button("Save") {
                    let item = Banner(text: self.text.trimmingCharacters(in: .whitespacesAndNewlines))
                    self.banners.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(banners: Banners())
    }
}
