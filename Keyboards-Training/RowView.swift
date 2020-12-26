//
//  RowView.swift
//  Keyboards-Training
//
//  Created by Jonas Yang on 2020/12/21.
//

import SwiftUI

struct RowView: View, Identifiable {
    
    let id = UUID()
    
    let keys: [String]
    
    var body: some View {
        HStack {
            ForEach(keys, id: \.self) {
                KeyView($0)
            }
        }
    }

}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(keys: [String]())
    }
}
