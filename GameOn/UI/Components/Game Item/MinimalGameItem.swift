//
//  MinimalGameItem.swift
//  GameOn
//
//  Created by Andika on 06/08/21.
//

import SwiftUI

struct MinimalGameItem: View {
    var game: Game

    var body: some View {
        NavigationLink(
            destination: GameDetailView(gameId: game.gameId, gameScreenshot: game.shortScreenshots ?? []),
            label: {
                VStack(alignment: .leading, spacing: 14) {
                    LargeBackgroundImage(imageUrl: game.backgroundUrl)

                    HStack {
                        VStack(alignment: .leading) {
                            Text(game.name ?? "")
                                .font(.headline)
                                .bold()
                                .padding(.bottom, 2)

                            if let genreText = game.genreText {
                                Text(genreText)
                                    .font(.subheadline)
                                    .foregroundColor(.systemGray)
                            }
                        }

                        Spacer()

                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)

                        Text(game.ratingString)
                            .font(.subheadline)
                            .foregroundColor(.systemGray)
                    }

                    if let esrbRating = game.esrbRating?.name, !esrbRating.isEmpty {
                        Text(esrbRating)
                            .font(.subheadline)
                            .foregroundColor(.systemGray)
                    } else {
                        Text(LocalizedStringKey("RATE_PENDING_OR_UNAVAILABLE"))
                            .font(.subheadline)
                            .foregroundColor(.systemGray)
                    }
                }
            }).buttonStyle(PlainButtonStyle())
    }
}

struct MinimalGameItem_Previews: PreviewProvider {
    static var previews: some View {
        MinimalGameItem(game: Game.fake)
            .previewLayout(.sizeThatFits)
    }
}
