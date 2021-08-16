//
//  LoadingComponent.swift
//  GameOn
//
//  Created by Andika on 07/08/21.
//

import SwiftUI
import SwiftUIX

struct LoadingComponent: View {
    var title: LocalizedStringKey = LocalizedStringKey("LOADING")

    var body: some View {
        VStack {
            ActivityIndicator()
                .padding(.bottom, 8)

            Text(title)
                .font(.callout)
                .foregroundColor(.systemGray)
        }
    }
}

struct LoadingComponent_Previews: PreviewProvider {
    static var previews: some View {
        LoadingComponent()
    }
}
