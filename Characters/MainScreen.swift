import UIKit

class MainScreen: UIViewController {

    // MARK: - Properties

    private let networkManager: NetworkProtocol

    // MARK: - Initializationa

    init(networkManager: NetworkProtocol) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
        self.networkManager.setURL(with: "https://rickandmortyapi.com/api/character")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSubviews()

        Task {
            let a = try await self.networkManager.fetchTwoPhotos()
            print(a)
        }

    }

    private func setupSubviews() {
        self.view.backgroundColor = .white
    }
}

