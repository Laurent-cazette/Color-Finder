//
//  SelectColor.swift
//  Color Finder
//
//  Created by Laurent Cazette on 13/09/2022.
//

import SwiftUI

struct SelectColor: View {
    @State private var bgColor = Color(.sRGB, red: 0, green: 0, blue: 0)
    var body: some View {
        VStack {
            ColorPicker("Select the wanted Color", selection: $bgColor)
            NavigationLink("Search", destination: ColorDetectionView(inputColor: bgColor))
        }
        .padding()
    }
}

struct SelectColor_Previews: PreviewProvider {
    static var previews: some View {
        SelectColor()
    }
}
