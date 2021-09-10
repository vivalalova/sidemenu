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
        Button("hello world2") {
            withAnimation { self.x = 0 }
        }
        .sidemenu(x: $x) { close in
            Color.red
                .frame(width: 120)
                .onTapGesture {
                    close()
                }
        }        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
