//
//  ErrorComponent.swift
//  GameOn
//
//  Created by Andika on 07/08/21.
//

import SwiftUI

struct ErrorComponent: View {

    var image: String = "img.error"
    var errorMessage: LocalizedStringKey

    var height: CGFloat = 75

    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: height)
                .padding(.bottom)

            Text(errorMessage)
                .foregroundColor(.systemGray)
                .multilineTextAlignment(.center)
        }.padding()
    }
}

struct ErrorComponent_Previews: PreviewProvider {
    static var previews: some View {
        ErrorComponent(errorMessage: "Lorem dorem ipsum dolor")
            .previewLayout(.sizeThatFits)
    }
}
