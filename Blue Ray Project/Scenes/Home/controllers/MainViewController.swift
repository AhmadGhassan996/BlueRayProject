//
//  MainViewController.swift
//  Blue Ray Project
//
//  Created by AhmadSulaiman on 15/12/2023.
//

import UIKit
import Foundation
import Kingfisher
class MainViewController: UIViewController {
    lazy private var useCase: RadiatorUseCaseProtocol = APIRadiatorUseCase()
    @IBOutlet private weak var collectionView: UICollectionView!
    private var shimmerEffect = ShimmerEffect()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupShimmerEffect()
                setupCollectionView()
               fetchContentData()
    }
    private func setupShimmerEffect() {
           shimmerEffect.frame = view.bounds
           view.addSubview(shimmerEffect)
       }
    private func fetchContentData() {
          useCase.fetchDataInSections { [weak self] success in
              guard let self = self else { return }
               DispatchQueue.main.async {
                   self.shimmerEffect.removeFromSuperview()
                   if success {
                       self.collectionView.reloadData()
                   } else {
                      print("error")
                   }
               }
           }
       }
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: CellId.descriptionCellId , bundle: nil), forCellWithReuseIdentifier: CellId.descriptionCellId)
        collectionView.register(UINib(nibName: CellId.RadiatorCellId , bundle: nil), forCellWithReuseIdentifier: CellId.RadiatorCellId)
        collectionView.dataSource = self
        collectionView.collectionViewLayout = sectionsLayout()
    }
  private func sectionsLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layout in
            guard let self = self else { return nil}
            let sections = self.useCase.pageSections[sectionIndex]
            switch sections {
            case .description:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(243)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(243)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 25, leading: 25, bottom: 25, trailing: 25)
                return section
            case .coverImage:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 25, leading: 25, bottom: 25, trailing: 25)
                return section
            case .arrayOfImages:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100)),repeatingSubitem: item, count: 4)
                group.interItemSpacing = .fixed(10)

                let section = NSCollectionLayoutSection(group: group)
                                section.contentInsets = .init(top: 25, leading: 25 , bottom: 25, trailing: 25)
                return section
            }
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return useCase.pageSections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return useCase.pageSections[section].items
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch useCase.pageSections[indexPath.section] {
            
        case .description(let title, let desc):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId.descriptionCellId, for: indexPath) as! DescriptionCell
            cell.config(title: title, description: desc)
                return cell
        case .coverImage(let image):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId.RadiatorCellId, for: indexPath) as! RadiatorImageCell
            cell.config(image: image)
            return cell
        case .arrayOfImages(let data):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId.RadiatorCellId, for: indexPath) as! RadiatorImageCell
            let image = data[indexPath.row].imgLink
            cell.config(image: image)
            return cell
        }
    }
}
