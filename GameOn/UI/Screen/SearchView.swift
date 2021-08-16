//
//  SearchView.swift
//  GameOn
//
//  Created by Andika on 05/08/21.
//

import SwiftUI
import SwiftUIX

struct SearchView: View {
    @State var keywords: String = ""

    @State var isSearching: Bool = false
    @State var isEditing: Bool = false
    @State var showAccountModal: Bool = false

    @StateObject var accountViewModel = AccountViewModel()

    @ObservedObject var discoveryGameViewModel: DiscoveryGameViewModel
    @ObservedObject var searchGameViewModel: SearchGameViewModel

    var body: some View {
        NavigationView {
            VStack {
                if keywords != "" {
                    SearchResultView(isSearching: $isSearching,
                                     keywords: $keywords,
                                     searchGameViewModel: searchGameViewModel)
                } else {
                    DiscoveryView(discoveryGameViewModel: discoveryGameViewModel)
                }
            }.navigationSearchBar {
                SearchBar("Search...", text: $keywords.onChange(perform: { _ in
                    searchQuery()
                }), isEditing: $isEditing, onCommit: {
                    isSearching = true
                    searchQuery()
                }).onCancel {
                    isSearching = false
                }.showsCancelButton(isEditing)
            }.navigationTitle(LocalizedStringKey("SEARCH"))
            .navigationViewStyle(StackNavigationViewStyle())
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    ToolbarItemView(showAccountSheet: $showAccountModal)
                }
            }
        }.navigationSearchBarHiddenWhenScrolling(false)
        .sheet(isPresented: $showAccountModal, content: {
            AccountView(accountViewModel: accountViewModel)
        })
    }

    private func searchQuery() {
        searchGameViewModel.fetchSearch(query: keywords)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(discoveryGameViewModel: DiscoveryGameViewModel(), searchGameViewModel: SearchGameViewModel())
    }
}

struct DiscoveryView: View {
    @ObservedObject var discoveryGameViewModel: DiscoveryGameViewModel

    var body: some View {
        ContentContainer(isLoading: $discoveryGameViewModel.isLoading,
                         isError: $discoveryGameViewModel.isError,
                         error: $discoveryGameViewModel.error,
                         loadingText: LocalizedStringKey("DISCOVERING_GAMES")) {
            VStack(alignment: .leading) {
                HStack {
                    Text(LocalizedStringKey("DISCOVER_GAMEON"))
                        .font(.title2)
                        .bold()

                    Spacer()
                }

                ForEach(discoveryGameViewModel.games, id: \.gameId) { game in
                    MinimalGameItem(game: game)
                        .padding(.bottom)
                }
            }
        }
    }
}

struct SearchResultView: View {
    @Binding var isSearching: Bool
    @Binding var keywords: String
    @ObservedObject var searchGameViewModel: SearchGameViewModel

    var body: some View {
        ContentContainer(isLoading: $searchGameViewModel.isLoading,
                         isError: $searchGameViewModel.isError,
                         error: $searchGameViewModel.error,
                         data: $searchGameViewModel.games,
                         enableEmptyContent: $isSearching,
                         loadingText: LocalizedStringKey("SEARCHING")) {
            VStack(alignment: .leading) {
                HStack {
                    Text(LocalizedStringKey("RESULT_FOR \(keywords)"))
                        .font(.title2)
                        .bold()

                    Spacer()
                }

                ForEach(searchGameViewModel.games, id: \.gameId) { game in
                    MinimalGameItem(game: game)
                        .padding(.bottom)
                }
            }
        }
    }
}
