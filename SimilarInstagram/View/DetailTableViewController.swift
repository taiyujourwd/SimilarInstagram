//
//  DetailTableViewController.swift
//  SimilarInstagram
//
//  Created by Tai on 2022/11/16.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    let searchResponse: String
    let postInfo:IGResponse.Graphql.User.PhotoDetail
    let indexPath:Int
    let userImageUrl:URL
    let userAcount:String
    
    init?(coder:NSCoder,userInfo:IGResponse, indexPath:Int ) {
        self.postInfo = userInfo.graphql.user.edge_owner_to_timeline_media
        self.indexPath = indexPath
        self.userImageUrl = userInfo.graphql.user.profile_pic_url
        self.userAcount = userInfo.graphql.user.username
        self.searchResponse = userInfo.graphql.user.full_name
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var userAccountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userAccountLabel.text = userAcount

    }
    
    //詳細頁面跳到所選的圖片位置
    var isShow = false
    override func viewDidLayoutSubviews() {
        if isShow == false{
            tableView.scrollToRow(at: IndexPath(item: indexPath, section: 0), at: .top, animated: true)
            isShow = true
            
        }
    }

    @IBAction func backToPrepage(_ sender: Any) {
        self.dismiss(animated: true)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return postInfo.edges.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(DetailTableViewCell.self)", for: indexPath) as! DetailTableViewCell

        // Configure the cell...
        cell.userPhotoImageView.kf.setImage(with: self.userImageUrl)
        cell.userPostImageView.kf.setImage(with: postInfo.edges[indexPath.row].node.display_url)
        cell.userNameLabel.text = userAcount
        cell.detailUserNameLabel.text = "\(String(describing: self.searchResponse))"
        cell.postNiceLabel.text = "\(postInfo.edges[indexPath.row].node.edge_liked_by.count) 個讚"
        cell.postTextLabel.text = postInfo.edges[indexPath.row].node.edge_media_to_caption.edges[0].node.text
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
