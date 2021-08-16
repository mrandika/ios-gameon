//
//  ToolbarItemView.swift
//  GameOn
//
//  Created by Andika on 10/08/21.
//

import SwiftUI

struct ToolbarItemView: View {
    @Binding var showAccountSheet: Bool

    var body: some View {
        return Button(action: {
            showAccountSheet.toggle()
        }, label: {
            Image(systemName: "person.circle")
        })
    }
}

struct ToolbarItemView_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarItemView(showAccountSheet: .constant(false))
        ToolbarItemView(showAccountSheet: .constant(true))
    }
}
