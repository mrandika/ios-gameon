//
//  ContentView.swift
//  GameOn
//
//  Created by Andika on 05/08/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext

    @ObservedObject var stateObservable = StateObservable.shared
    @ObservedObject var favoriteGameViewModel = FavoriteGameViewModel.shared

    @ObservedObject var platformViewModel = PlatformViewModel.shared
    @ObservedObject var platformGameViewModel = PlatformGameViewModel.shared

    @StateObject var topRatedGameViewModel = TopRatedGameViewModel()
    @StateObject var newReleaseGameViewModel = NewReleaseGameViewModel()

    @StateObject var discoveryGameViewModel = DiscoveryGameViewModel()
    @StateObject var searchGameViewModel = SearchGameViewModel()

    @State var tabSelection: TabItems = .topRated

    var body: some View {
        TabView(selection: $tabSelection) {
            TopRatedView(topRatedGameViewModel: topRatedGameViewModel)
                .tabItem {
                    Image(systemName: tabSelection == .topRated ? "star.fill" : "star")
                    Text(LocalizedStringKey("TOP_RATED"))
                }.tag(TabItems.topRated)
                .onAppear {
                    topRatedGameViewModel.fetchTopRated()
                }

            NewReleaseView(newReleaseGameViewModel: newReleaseGameViewModel)
                .tabItem {
                    Image(systemName: "calendar")
                    Text(LocalizedStringKey("NEW_RELEASE"))
                }.tag(TabItems.newReleases)
                .onAppear {
                    newReleaseGameViewModel.fetchNewRelease()
                }

            PlatformView(platformGameViewModel: platformGameViewModel)
                .tabItem {
                    Image(systemName: tabSelection == .platforms ? "gamecontroller.fill" : "gamecontroller")
                    Text(LocalizedStringKey("PLATFORMS"))
                }.tag(TabItems.platforms)
                .onAppear {
                    platformViewModel.fetchSelectedPlatform()
                    platformGameViewModel.fetchPlatform(platforms: platformViewModel.selectedPlatforms)
                }

            FavoriteView(favoriteGameViewModel: favoriteGameViewModel)
                .tabItem {
                    Image(systemName: tabSelection == .favorites ? "heart.fill" : "heart")
                    Text(LocalizedStringKey("FAVORITES"))
                }.tag(TabItems.favorites)

            SearchView(discoveryGameViewModel: discoveryGameViewModel, searchGameViewModel: searchGameViewModel)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text(LocalizedStringKey("SEARCH"))
                }.tag(TabItems.search)
                .onAppear {
                    discoveryGameViewModel.fetchDiscovery()
                }
        }.accentColor(.systemIndigo)
        .sheet(isPresented: $stateObservable.passedOnBoarding, onDismiss: {
            stateObservable.passOnboarding()
        }, content: {
            OnboardingView(stateObservable: stateObservable)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environment(\.locale, .init(identifier: "en"))

            ContentView()
                .environment(\.locale, .init(identifier: "id"))
        }
    }
}
