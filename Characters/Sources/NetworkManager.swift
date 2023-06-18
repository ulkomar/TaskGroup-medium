import Foundation

protocol NetworkProtocol {
    func setURL(with url: String)
}

final class NetworkManager: NetworkProtocol {
    private var mainURL: URL?

    func setURL(with url: String) {
        self.mainURL = URL(string: url)
    }
}
