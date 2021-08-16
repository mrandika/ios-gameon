//
//  FavoriteView.swift
//  GameOn
//
//  Created by Andika on 10/08/21.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var favoriteGameViewModel = FavoriteGameViewModel.shared

    var body: some View {
        NavigationView {
            VStack {
                if favoriteGameViewModel.games.count == 0 {
                    ErrorComponent(image: "img.empty-favorite",
                                   errorMessage: LocalizedStringKey("FAVORITE_EMPTY"),
                                   height: 200)
                } else {
                    ScrollView {
                        VStack {
                            ForEach(favoriteGameViewModel.games, id: \.gameId) { game in
                                FavoriteGameItem(game: Game(
                                                    gameId: Int(game.gameId),
                                                    name: game.name,
                                                    released: game.released,
                                                    backgroundImage: game.backgroundImage,
                                                    rating: game.rating))

                                Divider()
                                    .padding(.vertical)
                            }
                        }.padding()
                    }
                }
            }.navigationBarTitle(LocalizedStringKey("FAVORITES"))
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear {
                favoriteGameViewModel.fetch()
            }
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView(favoriteGameViewModel: FavoriteGameViewModel(
                        favoritesGameService: FavoriteGameService(
                            persistenceController: PersistenceController())))
    }
}
