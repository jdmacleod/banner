//
//  DetailView.swift
//  banner
//
//  Created by Jason MacLeod on 12/1/19.
//  Copyright © 2019 Jason MacLeod. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    let banner: Banner
    @State private var inverted = false

    var body: some View {
        ZStack {
            if (self.inverted){
            Color(UIColor.systemBackground).colorInvert()
                .edgesIgnoringSafeArea(.all)
            } else {
                Color(UIColor.systemBackground)
                    .edgesIgnoringSafeArea(.all)
            }
            Button(action: {self.inverted.toggle()}) {
                VStack {
                    if (self.inverted) {
                        Text(banner.text)
                            .foregroundColor(Color(UIColor.label)).colorInvert()
                        .lineLimit(1)
                        .font(.custom("Menlo", size: 250))
                            .minimumScaleFactor(.leastNonzeroMagnitude)
                    } else {
                        Text(banner.text)
                            .foregroundColor(Color(UIColor.label)).lineLimit(1)
                            .font(.custom("Menlo", size: 250))
                                .minimumScaleFactor(.leastNonzeroMagnitude)
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                       .padding()
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
            DetailView(banner: Banner(text: "testBannerText"))
    }
}
