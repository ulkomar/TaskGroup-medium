import Foundation

// MARK: - Protocol

protocol NetworkProtocol {
    func setURL(with url: String)
    func fetchImageDatas() async throws -> [Data]
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

    func fetchImageDatas() async throws -> [Data] {
        let characters = try await self.fetchCharacters().results

        let result = await withThrowingTaskGroup(of: Data.self) { group in
            for character in characters {
                group.addTask(operation: {
                    try await self.fetchData(url: character.image)!
                })
            }

            var closureInnerResult = [Data]()

            while let imgData = await group.nextResult() {
                switch imgData {
                case .success(let result):
                    closureInnerResult.append(result)
                default:
                    break
                }
            }

            return closureInnerResult
        }

        return result
    }

    // MARK: - Supplementary methods

    private func fetchCharacters() async throws -> Characters {
        let url = self.mainURL!
        let charactersData = try await URLSession.shared.data(from: url).0
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode(Characters.self, from: charactersData)
    }

    private func fetchData(url: String) async throws -> Data? {
        guard let url = URL(string: url) else { return nil }
        return try Data(contentsOf: url)
    }
}
