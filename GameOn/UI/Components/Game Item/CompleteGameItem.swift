//
//  CompleteGameItem.swift
//  GameOn
//
//  Created by Andika on 05/08/21.
//

import SwiftUI

struct CompleteGameItem: View {
    var game: Game

    var body: some View {
        NavigationLink(
            destination: GameDetailView(gameId: game.gameId, gameScreenshot: game.shortScreenshots ?? []),
            label: {
                VStack {
                    LargeBackgroundImage(imageUrl: game.backgroundUrl)

                    HStack {
                        Text(game.name ?? "")
                            .font(.headline)
                            .bold()

                        Spacer()

                        Group {
                            Image(systemName: "clock")
                            Text("\(game.playtimeString) \(Text(LocalizedStringKey("HOUR")))")
                                .font(.subheadline)
                        }.foregroundColor(.systemGray)
                    }.padding(.vertical, 2)

                    HStack {
                        if let releasedDate = game.releaseFormattedDate, !releasedDate.isEmpty, releasedDate != "" {
                            Text(releasedDate)
                                .font(.subheadline)
                                .foregroundColor(.systemGray)
                                .padding(.bottom)
                        } else {
                            Text(LocalizedStringKey("NOT_RELEASED"))
                                .font(.subheadline)
                                .foregroundColor(.systemGray)
                                .padding(.bottom)
                        }

                        Spacer()

                        Text(game.genreText ?? "")
                            .font(.caption)
                            .foregroundColor(.systemGray)
                            .padding(.bottom, 8)
                    }

                    HStack {
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)

                            Text(game.ratingString)
                                .font(.subheadline)
                                .foregroundColor(.systemGray)
                        }.padding(.trailing)

                        HStack {
                            Image("icn.metacritic")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 24)

                            Text("\(game.metacritic ?? 0)")
                                .bold()
                                .foregroundColor(game.metacriticColor)
                        }

                        Spacer()
                    }
                }
            }).buttonStyle(PlainButtonStyle())
    }
}

struct CompleteGameItem_Previews: PreviewProvider {
    static var previews: some View {
        CompleteGameItem(game: Game.fake)
            .previewLayout(.sizeThatFits)
    }
}
