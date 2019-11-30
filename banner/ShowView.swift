//
//  ShowView.swift
//  banner
//
//  Created by Jason MacLeod on 11/29/19.
//  Copyright © 2019 Jason MacLeod. All rights reserved.
//

import SwiftUI

struct ShowView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var banners: Banners
    
    var body: some View {
        NavigationView {
            Text("hello world")
        
            .navigationBarTitle("Display Banner")
            .navigationBarItems(trailing: Button("Done") {
        self.presentationMode.wrappedValue.dismiss()
        })
        }
    }
}

struct ShowView_Previews: PreviewProvider {
    static var previews: some View {
        ShowView(banners: Banners())
    }
}
