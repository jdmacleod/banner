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
    
    var body: some View {
        NavigationView {
            Form {
                TextField("BannerText", text: $text)
            }
            .navigationBarTitle(Text("Edit Banner"), displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                self.presentationMode.wrappedValue.dismiss()
                }, trailing: Button("Save") {
                    let item = Banner(text: self.text)
                    self.banners.items.append(item)
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
