//
//  PlatformViewModel.swift
//  GameOn
//
//  Created by Andika on 13/08/21.
//

import Foundation
import CoreData

class PlatformViewModel: NSObject, NSFetchedResultsControllerDelegate, ObservableObject {
    // MARK: - Static
    static let shared = PlatformViewModel(platformService: PlatformService(
                                                persistenceController: PersistenceController.shared))

    private let platformService: PlatformService
    private let fetchedResultsController: NSFetchedResultsController<GamePlatform>

    init(platformService: PlatformService) {
        self.platformService = platformService
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: platformService.platformsFetchRequest,
                                                                   managedObjectContext: platformService.context,
                                                                   sectionNameKeyPath: nil, cacheName: nil)
    }

    // MARK: - UI
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var error: Error?

    @Published var showAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""

    // MARK: - Data
    @Published var platforms: [Platform] = []
    @Published var selectedPlatforms: [GamePlatform] = []

    func provideDefaultPlatforms() {
        PersistenceController.shared.resetPlatform()
        self.selectedPlatforms.removeAll()

        let defaultPlatforms: [Platform] = [
            Platform(platformId: 4, name: "PC", slug: "pc"),
            Platform(platformId: 187, name: "PlayStation 5", slug: "playstation5"),
            Platform(platformId: 186, name: "Xbox Series S/X", slug: "xbox-series-x")
        ]

        for platform in defaultPlatforms {
            savePlatform(platform: platform)
        }
    }

    func fetchPlatforms() {
        self.isLoading = true
        self.isError = false

        self.fetchSelectedPlatform()

        platformService.platformLists { status in
            switch status {
            case .success(let result):
                DispatchQueue.main.async {
                    self.platforms = result.platforms

                    self.isLoading = false
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.isError = true
                    self.error = error
                }
            }
        }
    }

    func isPlatformSelected(platform: Platform) -> Bool {
        return selectedPlatforms.filter({ $0.platformId == platform.platformId }).isEmpty
    }

    func appendOrRemovePlatform(platform: Platform) {
        if self.isPlatformSelected(platform: platform) && selectedPlatforms.count < 4 {
            self.savePlatform(platform: platform)
        } else if !self.isPlatformSelected(platform: platform) && selectedPlatforms.count > 2 {
            self.deletePlatform(platformId: platform.platformId)
        } else {
            self.showAlert = true
            self.alertTitle = "ERROR_PLATFORM_DATA_SELECTION"
            self.alertMessage = "ERROR_PLATFORM_DATA_SELECTION_DESCRIPTION"
        }
    }

    func fetchSelectedPlatform() {
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()

        self.selectedPlatforms = fetchedResultsController.fetchedObjects ?? []
    }

    func savePlatform(platform: Platform) {
        let platformSelection = GamePlatform(context: platformService.context)
        platformSelection.platformId = Int32(platform.platformId)
        platformSelection.name = platform.name
        platformSelection.slug = platform.slug

        PersistenceController.shared.save()
        self.selectedPlatforms.append(platformSelection)

        self.fetchSelectedPlatform()
    }

    func deletePlatform(platformId: Int) {
        let context = platformService.context

        do {
            let platformRequest = platformService.checkPlatformLocally(platformId: platformId)
            let platform = try context.fetch(platformRequest).first!

            context.delete(platform)
            if let index = self.selectedPlatforms.firstIndex(where: { $0 === platform }) {
                self.selectedPlatforms.remove(at: index)
            }

            self.fetchSelectedPlatform()
        } catch {
            DispatchQueue.main.async {
                self.isLoading = false
                self.isError = true
                self.error = error
            }
        }
    }
}
