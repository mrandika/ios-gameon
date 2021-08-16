//
//  PlatformView.swift
//  GameOn
//
//  Created by Andika on 05/08/21.
//

import SwiftUI

struct PlatformView: View {
    @ObservedObject var platformGameViewModel: PlatformGameViewModel
    @ObservedObject var platformViewModel = PlatformViewModel.shared

    var body: some View {
        NavigationView {
            ContentContainer(isLoading: $platformGameViewModel.isLoading,
                             isError: $platformGameViewModel.isError,
                             error: $platformGameViewModel.error,
                             usePadding: false) {
                ForEach(platformViewModel.selectedPlatforms, id: \.platformId) { platform in
                    HorizontalGameList(platformName: platform.name ?? "",
                                       gameData: platformGameViewModel.games[platform] ?? [])

                    Divider().padding(.horizontal)
                }
            }.navigationBarTitle(LocalizedStringKey("PLATFORMS"))
            .navigationViewStyle(StackNavigationViewStyle())
        }.onAppear {
            platformViewModel.fetchSelectedPlatform()
            platformGameViewModel.fetchPlatform(platforms: platformViewModel.selectedPlatforms)
        }
    }
}

struct PlatformView_Previews: PreviewProvider {
    static var previews: some View {
        PlatformView(platformGameViewModel: PlatformGameViewModel())
    }
}

struct HorizontalGameList: View {
    var platformName: String
    var gameData: [Game]

    var body: some View {
        LazyVStack(alignment: .leading) {
            Text(LocalizedStringKey("GAMES_ON_PLATFORM \(platformName)"))
                .font(.title2)
                .bold()
                .padding(.top)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(gameData, id: \.gameId) { game in
                        SimpleGameItem(game: game)
                            .padding(.vertical)
                            .padding(.leading)
                            .padding(.trailing, 8)
                    }
                }
            }
        }
    }
}
