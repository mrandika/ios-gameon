//
//  ContentContainer.swift
//  GameOn
//
//  Created by Andika on 08/08/21.
//

import SwiftUI

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

struct ContentContainer<Content: View>: View {
    @ObservedObject var stateObservable = StateObservable.shared

    @Binding var isLoading: Bool
    @Binding var isError: Bool
    @Binding var error: Error?

    var data: Binding<[Game]>?
    var enableEmptyContent: Binding<Bool>?

    var usePadding: Bool = true
    var loadingText: LocalizedStringKey = LocalizedStringKey("LOADING")
    var content: () -> Content

    var body: some View {
        VStack {
            if stateObservable.connection == .unsatisfied {
                ErrorComponent(errorMessage: LocalizedStringKey("NO_CONNECTION"))
            } else if isLoading {
                LoadingComponent(title: loadingText)
            } else if isError {
                ErrorComponent(errorMessage: LocalizedStringKey(error?.localizedDescription ?? "UNKNOWN_ERROR"))
            } else if data?.wrappedValue.isEmpty == true && enableEmptyContent?.wrappedValue == true {
                ErrorComponent(image: "img.empty",
                               errorMessage: LocalizedStringKey("NO_MATCH_SEARCH"))
            } else {
                ScrollView {
                    LazyVStack {
                        content()
                    }.if(usePadding) { view in
                        view.padding()
                    }
                }
            }
        }
    }
}

struct ContentContainer_Previews: PreviewProvider {
    static var previews: some View {
        ContentContainer(isLoading: .constant(true),
                         isError: .constant(false),
                         error: .constant(HttpError.serverError(code: 500, message: "") as Error)) {
            VStack {
                Text("Hello World")
            }
        }.previewLayout(.sizeThatFits)

        ContentContainer(isLoading: .constant(false),
                         isError: .constant(true),
                         error: .constant(HttpError.serverError(code: 500, message: "") as Error)) {
            VStack {
                Text("Hello World")
            }
        }.previewLayout(.sizeThatFits)

        ContentContainer(isLoading: .constant(false),
                         isError: .constant(false),
                         error: .constant(HttpError.serverError(code: 500, message: "") as Error)) {
            VStack {
                Text("Hello World")
            }
        }.previewLayout(.sizeThatFits)
    }
}
