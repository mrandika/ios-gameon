//
//  FavoriteGameItem.swift
//  GameOn
//
//  Created by Andika on 15/08/21.
//

import SwiftUI

struct FavoriteGameItem: View {
    var game: Game

    var body: some View {
        NavigationLink(
            destination: GameDetailView(detailMode: .local, gameId: game.gameId, gameScreenshot: []),
            label: {
                HStack(alignment: .top) {
                    ZStack(alignment: .bottomTrailing) {
                        BackgroundImageView(imageUrl: game.backgroundUrl)
                            .frame(width: 180, height: 101)
                            .scaledToFit()
                            .cornerRadius(5)

                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)

                            Text(game.ratingString)
                                .font(.subheadline)
                                .foregroundColor(.systemGray)
                        }.padding(4)
                        .background(.white)
                        .cornerRadius(5)
                        .padding(4)
                    }.padding(.trailing, 4)

                    VStack(alignment: .leading) {
                        Text(game.name ?? "")
                            .font(.headline)
                            .bold()
                            .padding(.bottom, 2)
                            .fixedSize(horizontal: false, vertical: true)

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
                    }

                    Spacer()

                }
            }).buttonStyle(PlainButtonStyle())
    }
}

struct FavoriteGameItem_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteGameItem(game: Game.fake)
    }
}
