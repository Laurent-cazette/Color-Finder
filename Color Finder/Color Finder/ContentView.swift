//
//  ContentView.swift
//  Color Finder
//
//  Created by Laurent Cazette on 17/09/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            SelectColor()
                .navigationBarTitle("Color Selection", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
