//
//  SwiftUIView.swift
//  SwiftUIView
//
//  Created by Lova on 2021/9/11.
//

import SwiftUI

extension View {
    func sidemenu<Content: View>(x: Binding<CGFloat>, @ViewBuilder content: @escaping SideMenu<Content>.ContentBuilder) -> some View {
        ZStack {
            self

            SideMenu(x: x) { close in
                content(close)
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct SideMenu<Content: View>: View {
    @Binding var x: CGFloat

//    @Binding var isPresented: Bool

    typealias ContentBuilder = (_ close: @escaping () -> Void) -> Content
    var content: ContentBuilder

    init(x: Binding<CGFloat>, @ViewBuilder content: @escaping ContentBuilder) {
        self._x = x
        self.content = content
    }

    var body: some View {
        self.backGroundColor
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture(perform: self.close)
            .overlay(alignment: .leading) {
                GeometryReader { proxy in
                    let width = proxy.size.width

                    self.content(self.close)
                        .frame(maxWidth: width - 100)
                        .offset(x: x > -width ? x : x + 20)
                        .gesture(drag)
                }
            }
    }
}

extension SideMenu {
    var width: CGFloat { 300 }

    var backGroundColor: Color {
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

import Combine

extension SideMenu {
    class ViewModel: ObservableObject {
        private var bag = Set<AnyCancellable>()

        @Published var x: CGFloat
        @Published var isPresented: Bool

        init(x: Binding<CGFloat>, isPresented: Binding<Bool>) {
            self.x = x.wrappedValue
            self.isPresented = isPresented.wrappedValue

            $x.eraseToAnyPublisher()
                .assign(to: \.x, on: self)
                .store(in: &self.bag)
            
            $isPresented.eraseToAnyPublisher()
                .assign(to: \.isPresented, on: self)
                .store(in: &self.bag)

        }
    }
}
