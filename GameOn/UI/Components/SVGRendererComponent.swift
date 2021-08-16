//
//  SVGRendererComponent.swift
//  GameOn
//
//  Created by Andika on 12/08/21.
//

import SwiftUI

struct SVGRendererComponent: View {
    @Environment(\.colorScheme) var colorScheme
    var name: String

    var body: some View {
        Image(name)
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .foregroundColor(colorScheme == .dark ? .white : .black)
    }
}

struct SVGRendererComponent_Previews: PreviewProvider {
    static var previews: some View {
        SVGRendererComponent(name: "icn.store.egs")
    }
}
