//
//  FavoriteButton.swift
//  GameOn
//
//  Created by Andika on 12/08/21.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isFavorited: Bool

    var body: some View {
        HStack {
            Image(systemName: isFavorited ? "heart.fill" : "heart")
                .padding(.trailing, 8)

            Text(LocalizedStringKey(isFavorited ? "FAVORITED" : "ADD_TO_FAVORITES"))
                .font(.callout)
        }.foregroundColor(.white)
        .padding()
        .background(Color.systemIndigo.cornerRadius(5))
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isFavorited: .constant(true))
            .previewLayout(.sizeThatFits)

        FavoriteButton(isFavorited: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
