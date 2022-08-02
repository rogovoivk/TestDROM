//
//  ViewController.swift
//  TestDROM
//
//  Created by Vladoslav on 25.07.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    
    var images: [UIImage] = []
    var arrAllImages : [URL?] = [URL(string:"https://krasivosti.pro/uploads/posts/2021-04/thumbs/1617876320_32-p-koshka-oboi-koshka-mila-54.jpg"),
                                               URL(string:"https://panda.kr.ua/wp-content/uploads/2022/02/chestvuem-kotikov-i-koshek-vseh-mastej-a-zaodno-teh-kto-nosit-koshachju-familiju-9e93a7b.jpg"),
                                               URL(string:"https://deswal.ru/cats/1600-1200/00000079.jpg"),
                                               URL(string:"https://sk-news.ru/upload/iblock/d0c/27.jpg"),
                                               URL(string:"https://webmg.ru/wp-content/uploads/2020/12/1-91-800x600.jpg"),
                                               URL(string:"https://images.wallpaperscraft.ru/image/single/kot_koshka_pitomets_160374_800x600.jpg")]
    
    var arrImagesForCV: [URL?]?
    
    private let refrehControl: UIRefreshControl = {
        let refrehControl = UIRefreshControl()
        refrehControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        
        return refrehControl
    }()
    
    @objc private func refresh(sender: UIRefreshControl){
        arrImagesForCV = arrAllImages
        collectionView?.reloadData()
        
        sender.endRefreshing()
    }
    
    private var collectionView: UICollectionView?


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        print("start app")
        
        arrImagesForCV = arrAllImages

        
        let layout = NoFadeFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.refreshControl = refrehControl
        
        guard let collectionView = collectionView else {
            return
        }

        
        collectionView.register(CustomCollectionCell.self, forCellWithReuseIdentifier: CustomCollectionCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds

        
    }

    
    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.collectionViewLayout.invalidateLayout()
        collectionView? .frame = view.bounds
    }

}



extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImagesForCV!.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionCell.identifier, for: indexPath) as! CustomCollectionCell

        cell.setupURL(url: arrImagesForCV![indexPath.item]!)


        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.width - 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        arrImagesForCV!.remove(at: indexPath.item)
        
        self.collectionView?.deleteItems(at: [indexPath])
    }
    

}

class NoFadeFlowLayout: UICollectionViewFlowLayout {

    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attrs = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)
        attrs?.alpha = 1.0
        return attrs
    }

    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let attributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath)
            attributes?.alpha = 1
        let endX = self.collectionView!.frame.width
        let endTransform: CATransform3D = CATransform3DMakeTranslation(endX, 0, 0)
        attributes?.transform3D = endTransform

        return attributes
    }

}

