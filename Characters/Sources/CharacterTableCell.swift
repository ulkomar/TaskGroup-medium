import UIKit

final class CharacterCell: UITableViewCell {

    // MARK: - Properties

    private var image: UIImageView = .init(image: .init())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setter

    func set(with image: UIImage) {
        self.image.image = image
    }
}

// MARK: - Layout

private extension CharacterCell {
    func setupSubviews() {
        self.addSubview(self.image)
        self.setupLayout()
    }

    func setupLayout() {
        self.image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.image.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            self.image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            self.image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            self.image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15)
        ])
    }
}
