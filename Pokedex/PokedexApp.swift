//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Rodrigo Ryo Aoki on 23/09/25.
//

import SwiftUI

@main
struct PokedexApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeBuilder.make()
            }
        }
    }
}
