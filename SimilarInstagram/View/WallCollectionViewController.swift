//
//  WallCollectionViewController.swift
//  SimilarInstagram
//
//  Created by Tai on 2022/11/16.
//

import UIKit
import Kingfisher //取得URL圖片的package

private let reuseIdentifier = "Cell"

class WallCollectionViewController: UICollectionViewController {
    var userInfo: IGResponse?
    var postImages = [IGResponse.Graphql.User.PhotoDetail.Edges]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        let searchResponse: IGResponse = load("iambaijiji")
        self.userInfo = searchResponse
        self.postImages = (self.userInfo?.graphql.user.edge_owner_to_timeline_media.edges)!
        
        configureCellSize()
    }
    
    //讀取JSON檔的函數
    func load<T: Decodable>(_ filename: String) -> T {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: "json") else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) in main bundle:\n\(error)")
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
    
    //設定Cell的大小及間距
    func configureCellSize() {
        let itemSpace: Double = 4
        let columnCount: Double = 3
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let width = floor((collectionView.bounds.width - itemSpace * (columnCount - 1)) / columnCount)
        flowLayout?.itemSize = CGSize(width: width, height: width)
        flowLayout?.estimatedItemSize = .zero
        flowLayout?.minimumInteritemSpacing = itemSpace
        flowLayout?.minimumLineSpacing = itemSpace
    }
    
    //傳送資訊到詳細頁面
    @IBSegueAction func showDetailSegue(_ coder: NSCoder) -> DetailTableViewController? {
        guard let row = collectionView.indexPathsForSelectedItems?.first?.row else { return nil}
        return DetailTableViewController(coder: coder, userInfo: userInfo!, indexPath: row)
                
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return postImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(WallCollectionViewCell.self)", for: indexPath) as! WallCollectionViewCell
    
        // Configure the cell
        cell.postImageView.kf.setImage(with: postImages[indexPath.row].node.display_url)
    
        return cell
    }
    
    //WallHeaderCollectionReusableView
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //ReusableView的ofKind設定為Header, ID對象是userInfo的reusableView, as轉型為自訂reusableView型別
        guard let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(WallHeaderCollectionReusableView.self)", for: indexPath) as? WallHeaderCollectionReusableView else { return UICollectionReusableView() }
        
        let searchResponse: IGResponse = load("iambaijiji")
        
        reusableView.userPhotoImageView.kf.setImage(with: searchResponse.graphql.user.profile_pic_url)
        reusableView.userPhotoImageView.layer.cornerRadius = 50
        reusableView.userNameLabel.text = searchResponse.graphql.user.full_name
        reusableView.userCategoryLabel.text = searchResponse.graphql.user.category_name
        reusableView.biographyLabel.text = searchResponse.graphql.user.biography
        reusableView.facebookUrlLabel.text = "\(searchResponse.graphql.user.external_url)"
        let totalPostNum = (searchResponse.graphql.user.edge_owner_to_timeline_media.count + searchResponse.graphql.user.edge_felix_video_timeline.count)
        reusableView.postNumLabel.text = "\(totalPostNum)"
        reusableView.fansNumLabel.text = "\(searchResponse.graphql.user.edge_followed_by.count)"
        reusableView.trackerNumLabel.text = "\(searchResponse.graphql.user.edge_follow.count)"
        return reusableView
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
