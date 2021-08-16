//
//  TopRatedView.swift
//  GameOn
//
//  Created by Andika on 05/08/21.
//

import SwiftUI

struct TopRatedView: View {
    @ObservedObject var topRatedGameViewModel: TopRatedGameViewModel

    var body: some View {
        NavigationView {
            ContentContainer(isLoading: $topRatedGameViewModel.isLoading,
                             isError: $topRatedGameViewModel.isError,
                             error: $topRatedGameViewModel.error) {
                ForEach(topRatedGameViewModel.games, id: \.gameId) { game in
                    CompleteGameItem(game: game)

                    Divider()
                        .padding(.vertical)
                }
            }
            .navigationBarTitle(LocalizedStringKey("TOP_RATED"))
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct TopRatedView_Previews: PreviewProvider {
    static var previews: some View {
        TopRatedView(topRatedGameViewModel: TopRatedGameViewModel())
    }
}
