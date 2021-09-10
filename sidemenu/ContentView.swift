//
//  ContentView.swift
//  sidemenu
//
//  Created by Lova on 2021/9/11.
//

import SwiftUI

struct ContentView: View {
    @State var x: CGFloat = -300

    var body: some View {
        ZStack {
            Button("hello world2") {
                withAnimation { self.x = 0 }
            }

            SideMenu(x: $x)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
