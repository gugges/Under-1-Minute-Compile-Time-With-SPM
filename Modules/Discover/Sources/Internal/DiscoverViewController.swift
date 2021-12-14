
import Interfaces
import UIKit

final class DiscoverViewController: UIViewController {
    
    private let interfaces: Interfaces
    private static let sectionHeaderElementKind = "section-header-element-kind"
    
    private lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = .init(frame: view.bounds, collectionViewLayout: Self.createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<Int, Int> = {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, Int> {
            cell, indexPath, identifier in
            
            var colors: [UIColor] = [.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemTeal, .systemBlue, .systemIndigo, .systemPurple]
            colors = indexPath.section == 0 ? colors : colors.reversed()

            cell.contentView.backgroundColor = colors[indexPath.item % colors.count]
            cell.contentView.layer.cornerRadius = 6
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<UICollectionViewListCell>(elementKind: Self.sectionHeaderElementKind) {
            supplementaryView, string, indexPath in
            
            var content = supplementaryView.defaultContentConfiguration()
            content.text = "More items"
            content.textProperties.font = .systemFont(ofSize: 22, weight: .medium)
            content.textProperties.color = .white
            
            supplementaryView.contentConfiguration = content
        }
        
        let dataSource: UICollectionViewDiffableDataSource<Int, Int> = .init(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
        
        dataSource.supplementaryViewProvider = { [weak self] view, kind, indexPath in
            return self?.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
        
        return dataSource
    }()
    
    // MARK: - Init
    
    init(interfaces: Interfaces) {
        self.interfaces = interfaces
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Discover"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(collectionView)

        var snapshot: NSDiffableDataSourceSnapshot<Int, Int> = .init()

        var identifierOffset: Int = 0
        let itemsPerSection: Int = 40

        for section in 0..<2 {
            snapshot.appendSections([section])

            let maxIdentifier: Int = identifierOffset + itemsPerSection
            snapshot.appendItems(Array(identifierOffset..<maxIdentifier))
            identifierOffset += itemsPerSection
        }

        dataSource.apply(snapshot, animatingDifferences: false)
        collectionView.scrollToItem(at: .init(item: 1, section: 0), at: .centeredHorizontally, animated: false)
    }

}

// MARK: - UICollectionViewLayout

extension DiscoverViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interfaces.logInterface.debug("Did select item \(indexPath.item) in Section \(indexPath.section)")
    }
}


// MARK: - UICollectionViewLayout

extension DiscoverViewController {
    
    private static func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            return sectionIndex == 0 ? bannerSection() : tileSection()
        }
    }
    
    private static func bannerSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                            heightDimension: .fractionalHeight(1.0)))
        
        let inset: CGFloat = 10
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

        let containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85),
                                                                                                   heightDimension: .fractionalHeight(0.4)),
                                                                subitems: [item])
        
        let section = NSCollectionLayoutSection(group: containerGroup)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets = .init(top: 0, leading: 0, bottom: inset, trailing: 0)
        
        return section
    }

    private static func tileSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                            heightDimension: .fractionalHeight(1.0)))
        
        let inset: CGFloat = 10
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

        let containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                                  heightDimension: .fractionalWidth(0.5)),
                                                                subitem: item,
                                                                count: 2)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(44))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: Self.sectionHeaderElementKind,
                                                                        alignment: .top)
        
        let section = NSCollectionLayoutSection(group: containerGroup)
        section.contentInsets = .init(top: 0, leading: inset, bottom: 0, trailing: inset)
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }
    
}
