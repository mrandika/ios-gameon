//
//  GameDetailView.swift
//  GameOn
//
//  Created by Andika on 07/08/21.
//

import SwiftUI

enum DetailMode {
    case api
    case local
}

struct GameDetailView: View {
    @Environment(\.managedObjectContext) var viewContext

    @StateObject var gameDetailViewModel = GameDetailViewModel()
    @ObservedObject var favoriteGameViewModel = FavoriteGameViewModel.shared

    var detailMode: DetailMode = .api

    var gameId: Int
    var gameScreenshot: [ShortScreenshot]

    var body: some View {
        ContentContainer(isLoading: $gameDetailViewModel.isLoading,
                         isError: $gameDetailViewModel.isError,
                         error: $gameDetailViewModel.error,
                         usePadding: false,
                         loadingText: LocalizedStringKey("GETTING_GAME_DETAILS")) {
            VStack(alignment: .leading) {
                ZStack(alignment: .bottom) {
                    BackgroundImageView(imageUrl: gameDetailViewModel.game.backgroundUrl)
                        .scaledToFit()

                    HStack {
                        Spacer()

                        Button(action: {
                            withAnimation {
                                if favoriteGameViewModel.gameExist {
                                    favoriteGameViewModel.delete(gameId: gameId)
                                } else {
                                    favoriteGameViewModel.save(game: gameDetailViewModel.game)
                                }
                            }
                        }, label: {
                            FavoriteButton(isFavorited: $favoriteGameViewModel.gameExist)
                                .frame(height: 25)
                        })
                    }.padding(.horizontal)
                }.padding(.bottom)
                .onAppear {
                    favoriteGameViewModel.checkGame(gameId: gameId)
                }

                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        Text(gameDetailViewModel.game.name ?? "")
                            .font(.title2)
                            .bold()
                            .padding(.top)
                            .padding(.bottom, 4)

                        HStack {
                            Image("icn.metacritic")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 24)

                            Text("\(gameDetailViewModel.game.metacritic ?? 0)")
                                .bold()
                                .foregroundColor(gameDetailViewModel.game.metacriticColor)
                        }
                    }

                    Spacer()

                    Image(gameDetailViewModel.game.esrbRating?.ratingImage ?? "esrb.rating-pending")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 64)
                }.padding([.bottom, .horizontal])

                if detailMode == .local {
                    LocalDataAlert()
                }

                if let gameDescription = gameDetailViewModel.game.descriptionRaw, !gameDescription.isEmpty {
                    InformationCellView(title: LocalizedStringKey("ABOUT_THIS_GAME")) {
                        Text(gameDescription)
                            .padding(.horizontal)
                    }
                }

                if let gameGenre = gameDetailViewModel.game.genreText, !gameGenre.isEmpty {
                    InformationCellView(title: LocalizedStringKey("GENRES")) {
                        Text(gameGenre)
                            .padding(.horizontal)
                    }
                }

                if let gameScreenshot = gameScreenshot, !gameScreenshot.isEmpty {
                    ImageGalleryComponent(gameScreenshot: gameScreenshot)
                }

                if let gameRating = gameDetailViewModel.game.rating,
                   let gameRateTop = gameDetailViewModel.game.ratingTop, gameRating != 0, gameRateTop != 0 {
                    InformationCellView(title: LocalizedStringKey("RATING_REVIEWS")) {
                        HStack(alignment: .center) {
                            if gameDetailViewModel.game.suggestionsCount != 0
                                && gameDetailViewModel.game.reviewsCount != 0 {
                                Spacer()
                            }

                            RatingComponent(rating: gameRating, ratingTop: gameRateTop)
                                .padding(.horizontal)

                            if gameDetailViewModel.game.suggestionsCount != 0
                                && gameDetailViewModel.game.reviewsCount != 0 {
                                Spacer()

                                SuggestionReviewComponent(
                                    suggestionsCount: gameDetailViewModel.game.suggestionsCount ?? 0,
                                                          reviewsCount: gameDetailViewModel.game.reviewsCount ?? 0)
                            }
                        }
                    }

                    if let gameRatings = gameDetailViewModel.game.ratings {
                        VStack(alignment: .leading) {
                            ForEach(gameRatings, id: \.ratingId) { rating in
                                VStack(alignment: .leading) {
                                    Text("""
                                        \(String(format: "%.f", round(rating.percent)))% \(Text(rating.title)
                                            .foregroundColor(rating.titleColor))
                                        """)
                                            .font(.system(.title2, design: .rounded))
                                            .bold()
                                            .padding(.top, 8)

                                    Text(LocalizedStringKey("USERS_COUNT \(rating.count)"))
                                        .font(.callout)
                                        .foregroundColor(.systemGray)
                                }
                            }
                        }.padding(.horizontal)
                    }
                }

                VStack(alignment: .leading) {
                    if let gameDevelopers = gameDetailViewModel.game.developers, !gameDevelopers.isEmpty {
                        InformationCellView(title: LocalizedStringKey("DEVELOPERS")) {
                            DeveloperCell(developers: gameDevelopers)
                                .padding(.horizontal)
                        }
                    }

                    if let gamePublishers = gameDetailViewModel.game.publishers, !gamePublishers.isEmpty {
                        InformationCellView(title: LocalizedStringKey("PUBLISHERS")) {
                            PublisherCell(publishers: gamePublishers)
                                .padding(.horizontal)
                        }
                    }
                }.padding(.bottom)
            }
        }.navigationBarTitle(LocalizedStringKey("GAME_DETAILS"))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            gameDetailViewModel.fetchDetail(gameId: gameId)
        }
    }
}

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailView(gameId: 1, gameScreenshot: [])
    }
}

struct InformationCellView<Content: View>: View {

    var title: LocalizedStringKey
    var content: () -> Content

    var body: some View {
        Group {
            Text(title)
                .font(.title2)
                .bold()
                .padding(.top)
                .padding(.bottom, 4)
                .padding(.horizontal)

            content()
        }
    }
}

struct DeveloperCell: View {
    var developers: [Developer]

    var body: some View {
        ForEach(developers, id: \.developerId) { developer in
            HStack {
                Text(developer.name)
                    .foregroundColor(.systemOrange)
            }.padding(.bottom, 4)
        }
    }
}

struct PublisherCell: View {
    var publishers: [Publisher]

    var body: some View {
        ForEach(publishers, id: \.publisherId) { publisher in
            HStack {
                Text(publisher.name)
                    .foregroundColor(.systemOrange)
            }.padding(.bottom, 4)
        }
    }
}

struct LocalDataAlert: View {
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "exclamationmark.triangle")
                .renderingMode(.template)
                .padding(.trailing, 2)

            Text(LocalizedStringKey("LOCAL_DATA_INCOMPLETE_DESCRIPTION"))
                .font(.body)

            Spacer()
        }.padding()
        .background(Color.systemIndigo.opacity(0.25).cornerRadius(5))
        .foregroundColor(.systemIndigo)
        .padding(.horizontal)
    }
}
