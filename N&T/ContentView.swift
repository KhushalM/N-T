//
//  ContentView.swift
//  N&T
//
//  Created by Khushal Mandavia on 10/8/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "house")
                }
            NotesView()
                .tabItem {
                    Label("Notes", systemImage: "note.text")
                }
            ThoughtsView()
                .tabItem {
                    Label("Thoughts", systemImage: "brain")
                }
            AddContentView()
                .tabItem {
                    Label("Add", systemImage: "plus")
                }
        }
        .accentColor(Theme.primaryColor)
        .background(Theme.backgroundColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
