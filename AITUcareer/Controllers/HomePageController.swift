//
//  HomePageController.swift
//  AITUcareer
//
//  Created by ZhZinekenov on 01.05.2023.
//

import UIKit

fileprivate class CustomCell: UICollectionViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 45),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    func setup(with item: HomePageDataModel) {
        titleLabel.text = item.itemTitle
        imageView.image = item.itemImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate class CollectionViewHeaderReusableView: UICollectionReusableView {
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
    let categoryTitleLbl = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(visualEffectView)
        
        self.backgroundColor = .clear
        categoryTitleLbl.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        categoryTitleLbl.textAlignment = .left
        self.addSubview(categoryTitleLbl)
        categoryTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            visualEffectView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            visualEffectView.topAnchor.constraint(equalTo: self.topAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            categoryTitleLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            categoryTitleLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            categoryTitleLbl.topAnchor.constraint(equalTo: self.topAnchor),
            categoryTitleLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            categoryTitleLbl.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }

    func setup(_ title: String) {
        categoryTitleLbl.text = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate enum Section {
    case section1
    case section2
    case section3
    case section4
}

class HomePageController: UIViewController, UICollectionViewDelegate {
    
    var collectionView: UICollectionView!
    
    
    lazy var layout: UICollectionViewCompositionalLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(360), heightDimension: .absolute(340))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
        section.interGroupSpacing = 0
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        
        return UICollectionViewCompositionalLayout(section: section)
    }()

    
    
    fileprivate lazy var dataSource = UICollectionViewDiffableDataSource<Section, HomePageDataModel>(collectionView: self.collectionView,
                                                                                                     cellProvider: self.cellProvider)
    lazy var cellProvider: (UICollectionView, IndexPath, HomePageDataModel) -> UICollectionViewCell? = { collectionView, indexPath, homePageItem in
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CustomCell else {
                return UICollectionViewCell()
            }
        
        cell.backgroundColor = UIColor(red: 0.086, green: 0.196, blue: 0.4118, alpha: 1)
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        cell.setup(with: homePageItem)

        
        return cell
        
    }
    
    override func viewDidLoad() {

        title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(profileButtonTapped))
        
        super.viewDidLoad()

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(CollectionViewHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")

        
        view.addSubview(collectionView)
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 896)
        ])
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard self != nil else { return UICollectionReusableView() }

            if kind == UICollectionView.elementKindSectionHeader {
                let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "HeaderView",
                    for: indexPath
                ) as? CollectionViewHeaderReusableView
                
                let section = categories[indexPath.section]
                headerView?.setup(section)
                return headerView
            }
            
            return nil
        }
        addItems(items: AdvicesItems, to: .section1)
        addItems(items: VacanciesItems, to: .section2)
        addItems(items: NewsItems, to: .section3)
        addItems(items: CompaniesItems, to: .section4)
        

        
        
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(45))
            let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            headerElement.pinToVisibleBounds = true
            headerElement.zIndex = 2
            headerElement.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            return headerElement
    }
    
    
    
    fileprivate func addItems(items: [HomePageDataModel], to section: Section) {
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([section])
        snapshot.appendItems(items, toSection: section)
        dataSource.apply(snapshot)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let homePageItem = dataSource.itemIdentifier(for: indexPath) else { return }
        let detailVC = HomePageDetailViewController(homePageItem: homePageItem)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    @objc func profileButtonTapped() {
        let detailVC = ProfileViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
