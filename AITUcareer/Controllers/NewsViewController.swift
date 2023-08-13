//
//  NewsViewController.swift
//  AITUcareer
//
//  Created by ZhZinekenov on 03.05.2023.
//

import UIKit

fileprivate enum Section {
    case section1
}



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
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    func setup(with item: NewsItem) {
        titleLabel.text = item.NewsTitle
        imageView.image = item.NewsImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class NewsViewController: UIViewController, UICollectionViewDelegate {
    
    var previousCollectionView: UICollectionView?

    var collectionView: UICollectionView!
    
    fileprivate lazy var dataSource = UICollectionViewDiffableDataSource<Section, NewsItem>(collectionView: self.collectionView, cellProvider: self.cellProvider)
    lazy var cellProvider: (UICollectionView, IndexPath, NewsItem) -> UICollectionViewCell? = { collectionView, indexPath, newsItem in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCell
        cell.backgroundColor = UIColor(red: 0.086, green: 0.196, blue: 0.4118, alpha: 1)
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        cell.setup(with: newsItem)
        
        
        return cell
    }
    
    override func viewDidLoad() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(profileButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: nil)
        title = "News"
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 0.086, green: 0.196, blue: 0.4118, alpha: 1)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 300, height: 280)
        layout.sectionInset = UIEdgeInsets(top: 30, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 70
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "Cell")

        view.addSubview(collectionView)
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 500)
        ])
        
        addItems(items: newsItemsArray, to: .section1)
    }
    
    fileprivate func addItems(items: [NewsItem], to section: Section) {
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([section])
        snapshot.appendItems(items, toSection: section)
        dataSource.apply(snapshot)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let newsItem = dataSource.itemIdentifier(for: indexPath) else { return }
        let detailVC = NewsDetailViewController(newsItem: newsItem)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    @objc func profileButtonTapped() {
        let detailVC = ProfileViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
