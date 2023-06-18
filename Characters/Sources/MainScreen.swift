import UIKit

final class MainScreen: UIViewController {

    // MARK: - Properties

    private let networkManager: NetworkProtocol
    private var characterDataImages = [UIImage]()
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(CharacterCell.self, forCellReuseIdentifier: "TableCell")
        return table
    }()


    // MARK: - Initializationa

    init(networkManager: NetworkProtocol) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSubviews()
        self.startNetworkProcess()
    }
}

// MARK: - Requests

private extension MainScreen {
    func startNetworkProcess() {
        self.networkManager.setURL(with: "https://rickandmortyapi.com/api/character")
        Task { @MainActor in
            let result = try await self.networkManager.fetchImageDatas()
            self.characterDataImages = []
            result.forEach { data in
                self.characterDataImages.append(UIImage(data: data)!)
            }
            self.tableView.reloadData()
        }
    }
}

// MARK: - Layout

private extension MainScreen {
    func setupSubviews() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)

        self.setupLayout()
    }

    func setupLayout() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate

extension MainScreen: UITableViewDelegate {

}

// MARK: - UITableViewDataSource

extension MainScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characterDataImages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableCell") as? CharacterCell else { return .init()}
        cell.set(with: self.characterDataImages[indexPath.row])
        return cell
    }
}
