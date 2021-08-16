//
//  NewReleaseView.swift
//  GameOn
//
//  Created by Andika on 05/08/21.
//

import SwiftUI
import SwiftUIX

struct NewReleaseView: View {
    @ObservedObject var newReleaseGameViewModel: NewReleaseGameViewModel

    var body: some View {
        NavigationView {
            ContentContainer(isLoading: $newReleaseGameViewModel.isLoading,
                             isError: $newReleaseGameViewModel.isError,
                             error: $newReleaseGameViewModel.error) {
                ForEach(newReleaseGameViewModel.games, id: \.gameId) { game in
                    CompleteGameItem(game: game)

                    Divider()
                        .padding(.vertical)
                }
            }
            .navigationBarTitle(LocalizedStringKey("NEW_RELEASE"))
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct NewReleaseView_Previews: PreviewProvider {
    static var previews: some View {
        NewReleaseView(newReleaseGameViewModel: NewReleaseGameViewModel())
    }
}
