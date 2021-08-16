//
//  GameCodeProfileView.swift
//  GameOn
//
//  Created by Andika on 14/08/21.
//

import SwiftUI
import SwiftUIX

struct GameCodeProfileView: View {
    @StateObject var gameCodeViewModel = GameCodeViewModel()

    var profile: Profile

    var body: some View {
        List {
            Section(header: Text(LocalizedStringKey("PERSONAL_DETAILS"))) {
                HStack {
                    Spacer()

                    Image("icn.profile-empty")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 128)
                        .clipShape(Circle())
                        .padding(.vertical)

                    Spacer()
                }

                HStack {
                    Text(LocalizedStringKey("USER_NAME"))

                    Spacer()

                    Text(profile.name)
                }

                HStack {
                    Text(LocalizedStringKey("GAMER_LEVEL"))

                    Spacer()

                    Text(LocalizedStringKey(profile.gamerLevel))
                }
            }

            Section(header: Text(LocalizedStringKey("SOCIAL_DETAILS"))) {
                HStack {
                    SVGRendererComponent(name: "icn.store-steam")
                        .frame(height: 32)
                        .padding(8)

                    Text(profile.steamName.isEmpty ? "-" : profile.steamName)
                }

                HStack {
                    SVGRendererComponent(name: "icn.store-egs")
                        .frame(height: 32)
                        .padding(8)

                    Text(profile.egsName.isEmpty ? "-" : profile.egsName)
                }
            }

            if let favoritedGames = profile.favoritedGameId, !favoritedGames.isEmpty {
                Section(header: Text(LocalizedStringKey("RECENT_FAVORITES"))) {
                    if gameCodeViewModel.isLoading {
                        HStack {
                            Spacer()

                            ActivityIndicator()

                            Spacer()
                        }
                    } else {
                        ForEach(gameCodeViewModel.games, id: \.gameId) { game in
                            Text(game.name ?? "")
                        }
                    }
                }
            }
        }.onAppear {
            gameCodeViewModel.fetchGame(gameId: profile.favoritedGameId ?? [])
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct GameCodeProfileView_Previews: PreviewProvider {
    static var previews: some View {
        GameCodeProfileView(profile: Profile.fake)
    }
}
