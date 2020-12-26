//
//  KeyView.swift
//  Keyboards-Training
//
//  Created by Jonas Yang on 2020/12/21.
//

import SwiftUI
import Combine

struct KeyView: View, Identifiable {
    @State var isFocused = false
    
    let keyInputSubject: KeyCommandPublisher
    let keyTipSubject: KeyCommandPublisher

    let id: String
    
    var body: some View {
        Text("\(id)")
            .foregroundColor(.black)
            .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .padding(3)
            .border(isFocused ? Color.blue : Color.gray, width: 2)
            .cornerRadius(8)
            .background(Color.white)
            .animation(.interactiveSpring())
            .onReceive(self.keyInputSubject) {
                if id == $0 as! String {
                    self.isFocused = true
                } else {
                    self.isFocused = false
                }
            }
            .onReceive(keyTipSubject) {
                if id == $0 as! String {
                    self.isFocused = true
                } else {
                    self.isFocused = false
                }
            }

    }
}

struct KeyView_Previews: PreviewProvider {
    static var previews: some View {
        KeyView<PassthroughSubject<String, Never>>(id: "A", keyInputSubject: PassthroughSubject(), keyTipSubject: PassthroughSubject())
    }
}
