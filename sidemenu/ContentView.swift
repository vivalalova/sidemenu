//
//  ContentView.swift
//  sidemenu
//
//  Created by Lova on 2021/9/11.
//

import SideMenuView
import SwiftUI

struct ContentView: View {
    @State var isPresented: Bool = true

    var body: some View {
        Button("hello world2") {
//            withAnimation {
                self.isPresented.toggle()
//            }
        }
        .sidemenu(isPresented: $isPresented) {
            Color.red
                .frame(width: 120)
                .onTapGesture {
                    self.isPresented = false
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
