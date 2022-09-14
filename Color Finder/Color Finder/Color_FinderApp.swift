//
//  Color_FinderApp.swift
//  Color Finder
//
//  Created by Laurent Cazette on 13/09/2022.
//

import SwiftUI

@main
struct Color_FinderApp: App {
    static var ImageTreatmentService: ImageTreatmentService?
    var body: some Scene {
        WindowGroup {
            SelectColor(service: Color_FinderApp.ImageTreatmentService!)
        }
    }
}
