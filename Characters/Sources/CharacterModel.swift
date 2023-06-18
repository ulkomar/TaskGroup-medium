struct Characters: Decodable {
    let results: [Result]

    struct Result: Decodable {
        let id: Int
        let name: String
        let image: String
    }
}


