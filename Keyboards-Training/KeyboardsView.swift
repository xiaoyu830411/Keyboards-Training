//
//  KeyboardsView.swift
//  Keyboards-Training
//
//  Created by Jonas Yang on 2020/12/21.
//

import SwiftUI
import Combine

struct KeyboardsView: View {
    
    let tipsPublisher = PassthroughSubject<Int, Never>()
    
    @State var rows = [RowView]()
    
    let keys = [["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
    ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
    ["Z", "X", "C", "V", "B", "N", "M"]]
    
    var body: some View {
        VStack {
            ForEach(keys, id:\.self) {
                let row = RowView(keys: $0)
            }
        }
        .onAppear() {
            self.tipsPublisher.send(0%26)
        }
    }
}

struct KeyboardsView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardsView()
    }
}
