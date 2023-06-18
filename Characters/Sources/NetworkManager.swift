import Foundation

// MARK: - Protocol

protocol NetworkProtocol {
    func setURL(with url: String)
    func fetchTwoPhotos() async throws -> (Data, Data)
}

// MARK: - Implementation

final class NetworkManager: NetworkProtocol {

    // MARK: - Properties

    private var mainURL: URL?

    // MARK: - Setter

    func setURL(with url: String) {
        self.mainURL = URL(string: url)
    }

    // MARK: - Protocol methods

    func fetchTwoPhotos() async throws -> (Data, Data) {
        let urlGroup = [
            "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            "https://rickandmortyapi.com/api/character/avatar/2.jpeg"
        ]

        async let firstPhoto = try await self.fetchData(from: urlGroup[0])
        async let secondPhoto = try await self.fetchData(from: urlGroup[1])

        let firstResponse = try await firstPhoto
        let secondResponse = try await secondPhoto

        return (firstResponse, secondResponse)
    }

    // MARK: Hidden private methods

    private func fetchData(from url: String) async throws -> Data {
        let url = URL(string: url)!
        return try Data(contentsOf: url)
    }
}
