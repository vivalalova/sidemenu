//
//  ContentView.swift
//  sidemenu
//
//  Created by Lova on 2021/9/11.
//

import SwiftUI

extension View {
    func sidemenu(x: Binding<CGFloat>) -> some View {
        ZStack {
            self

            SideMenu(x: x) { _ in
                Color.red
                    .frame(width: 120)
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct ContentView: View {
    @State var x: CGFloat = -300

    var body: some View {
        Button("hello world2") {
            withAnimation { self.x = 0 }
        }
        .sidemenu(x: $x)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
