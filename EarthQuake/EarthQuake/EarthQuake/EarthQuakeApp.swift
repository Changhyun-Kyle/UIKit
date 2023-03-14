//
//  EarthQuakeApp.swift
//  EarthQuake
//
//  Created by 강창현 on 2023/03/13.
//

import SwiftUI

@main
struct EarthQuakeApp: App {
    @StateObject var quakesProvider = QuakeProvider()
    var body: some Scene {
        WindowGroup {
            Quakes()
                .environmentObject(quakesProvider)
        }
    }
}
