//
//  SimpleGameItem.swift
//  GameOn
//
//  Created by Andika on 05/08/21.
//

import SwiftUI

struct SimpleGameItem: View {
    var game: Game

    var body: some View {
        NavigationLink(
            destination: GameDetailView(gameId: game.gameId, gameScreenshot: game.shortScreenshots ?? []),
            label: {
                VStack(alignment: .leading, spacing: 14) {

                    SmallBackgroundImage(imageUrl: game.backgroundUrl)

                    HStack {
                        Text(game.name ?? "")
                            .font(.headline)
                            .bold()

                        Spacer()

                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)

                        Text(game.ratingString)
                            .font(.subheadline)
                            .foregroundColor(.systemGray)
                    }

                    HStack {
                        if let releasedDate = game.releaseFormattedDate, !releasedDate.isEmpty, releasedDate != "" {
                            Text(LocalizedStringKey("AVAILABLE_SINCE \(releasedDate)"))
                                .font(.subheadline)
                                .foregroundColor(.systemGray)
                        } else {
                            Text(LocalizedStringKey("NOT_RELEASED"))
                                .font(.subheadline)
                                .foregroundColor(.systemGray)
                        }

                        Spacer()

                        Image("icn.metacritic")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 24)

                        Text("\(game.metacritic ?? 0)")
                            .bold()
                            .foregroundColor(game.metacriticColor)
                    }
                }.frame(maxWidth: 300)
            }).buttonStyle(PlainButtonStyle())
    }
}

struct SimpleGameItem_Previews: PreviewProvider {
    static var previews: some View {
        SimpleGameItem(game: Game.fake)
            .previewLayout(.sizeThatFits)
    }
}
