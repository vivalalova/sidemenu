//
//  SwiftUIView.swift
//  SwiftUIView
//
//  Created by Lova on 2021/9/11.
//

import SwiftUI

struct SideMenu: View {
    private var width: CGFloat { 300 }
    @Binding var x: CGFloat

    var body: some View {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().tableFooterView = UIView()

        return ZStack {
            Button("", action: self.close)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(self.backGround)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture(perform: self.close)

            HStack {
                SideMenuContent(changeAccount: {})
                    .frame(width: self.width)
                    .offset(x: x > -self.width ? x : x - 20)
                    .gesture(drag)

                Spacer()
            }
        }
    }

    var backGround: Color {
        let opacity = Double((self.x + self.width) / self.width) * 0.4
        return Color(Color.RGBColorSpace.sRGB, white: 0, opacity: opacity)
    }

    var drag: _EndedGesture<_ChangedGesture<DragGesture>> {
        DragGesture()
            .onChanged { value in
                if value.translation.width > 0 {
                    self.x = 0
                    return
                }
                self.x = value.translation.width
            }
            .onEnded {
                if $0.translation.width < -100 {
                    self.close()
                } else {
                    self.show()
                }
            }
    }

    func show() {
        print("show")
        withAnimation { self.x = 0 }
    }

    func close() {
        print("close")
        withAnimation { self.x = -self.width }
    }
}

struct SideMenuContent: View {
    typealias Callback = () -> Void

    @State var hasCompany: Bool = false
    var changeAccount: Callback

    var imageViewSize: CGFloat = 120.0

    var body: some View {
        VStack {
            List {
                VStack(alignment: .leading) {
                    Image(systemName: "person.fill")
                        .resizable(resizingMode: Image.ResizingMode.stretch)
                        .frame(width: imageViewSize, height: imageViewSize)
                        .cornerRadius(imageViewSize / 2)

                    Text("User Name")
                        .font(.title)

                    if hasCompany {
                        Button(action: self.changeAccount) {
                            Text("0").foregroundColor(Color.blue)
                        }
                    }
                }

                SideMenuRow(title: "1", action: {})
                SideMenuRow(title: "2", action: {})
                SideMenuRow(title: "3", action: {})
                SideMenuRow(title: "4", action: {})
                SideMenuRow(title: "5", action: {})
                SideMenuRow(title: "登出", action: {})
            }

            Spacer()
        }
        .background(Color.white)
    }
}

struct SideMenuRow: View {
    typealias Callback = () -> Void

    var title: String
    var action: Callback

    var body: some View {
        Button(action: self.action) {
            Text(self.title)
                .font(.headline)
                .fontWeight(.regular)
                .padding(.vertical)
        }
    }
}

struct SideMenu_Previews: PreviewProvider {
    @State static var x: CGFloat = -300

    static var previews: some View {
        ZStack {
            Button("hello world2") {
                withAnimation { self.x = 0 }
            }

            SideMenu(x: $x)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}
