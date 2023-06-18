import Foundation

// MARK: - Protocol

protocol NetworkProtocol {
    func setURL(with url: String)
}

// MARK: - Implementation

final class NetworkManager: NetworkProtocol {
    private var mainURL: URL?

    func setURL(with url: String) {
        self.mainURL = URL(string: url)
    }
}
