//
//  UsersListViewController.swift
//  UsersApp
//
//  Created by Padmaja Pathada on 3/30/23.
//

import UIKit

class UsersListViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableVW: UITableView!
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    @IBOutlet weak var profilePicImgVW: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    
    let cellReuseIdentifier = "UsersListCell"
    var loginObj = LoginResponse()
    var usersList = [userInfo]()
    var ownerUserInfo : userInfo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableVW.register(UINib(nibName: "UsersListTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        
        updateUI()
        
        //API Request
        let urlStr = Urls.baseURL.appending(Urls.secondURL.allUsers.rawValue)
        getUsersListRequest(urlStr: urlStr)
    }
    func updateUI(){
        if let username = loginObj.username{
            userNameLbl.text = username
        }
        downloadingImage()
    }
    func downloadingImage(){
        if let imageUrlStr = loginObj.image{
            APIManager.shared.downloadImage(imageUrlStr) { image, urlString in
                if let imageObject = image{
                    // performing UI operation on main thread
                        self.profilePicImgVW.image = imageObject
                }
            }
        }
    }
    
    func getUsersListRequest(urlStr:String){
       // let urlStr = Urls.baseURL.appending(Urls.secondURL.allUsers.rawValue)

        //Converting string to URL
        guard let url = URL(string: urlStr) else {
            return
        }
        
        
        APIManager.shared.makeAPIRequestCall(url: url, httpMethod: HTTPMethod.get, bodyData: nil) { (result: Result<AllUsersResponse, Error>) in
                switch result{
                case .success(let responseData):
                    print("success response data: \(responseData)")
                    self.getAllUsersResponse(response: responseData)
                case .failure(let error):
                    print("Failed: \(error)")
                    DispatchQueue.main.async {
                        // Update UI here
                        Alert.showAlertView(message: "No Response", vc: self)
                    }

                    
                }
            }

    }
    func getAllUsersResponse(response: AllUsersResponse){
        usersList.removeAll()
        for user in response.users{
            if let userInfo = user{
                if let username = userInfo.username{
                    if username != loginObj.username{
                        usersList.append(userInfo)
                    }
                    else if username == loginObj.username{
                        ownerUserInfo = userInfo
                    }
                }
            }
        }
        
        DispatchQueue.main.async {
            
                self.tableVW.reloadData()
        }
    }
    
    
    @IBAction func userAccountButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: constants.storyBoards.userDetails.rawValue, bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: constants.viewControllers.userDetails.rawValue) as! UserDetailViewController
       // nextViewController.userInfoObj = usersList[indexPath.row] as userInfo
        nextViewController.ownerUserInfo = self.ownerUserInfo
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UsersListViewController:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if usersList.count > 0{
            return usersList.count
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! UsersListTableViewCell
       // cell.cellView.layer.borderWidth = 1
        cell.cellView.layer.cornerRadius = 5
        cell.cellView.clipsToBounds = true
        let usersObj = usersList[indexPath.row] as userInfo
        if let userName = usersObj.username{
            cell.usernameLbl.text = "Username: \(userName)"
        }
        if let firstname = usersObj.firstName,let lastname = usersObj.lastName {
            cell.nameLbl.text = "Name: \(firstname) \(lastname)"
        }
        if let email = usersObj.email{
            cell.emailLbl.text = "Username: \(email)"
        }
        if let imageObj = usersObj.image{
            APIManager.shared.downloadImage(imageObj) { image, urlString in
                if let imageObj = image{
                    cell.profilePic.image = imageObj
                }
            }
        }

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: constants.storyBoards.userDetails.rawValue, bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: constants.viewControllers.userDetails.rawValue) as! UserDetailViewController
        nextViewController.userInfoObj = usersList[indexPath.row] as userInfo
       // nextViewController.ownerUserInfo = self.ownerUserInfo
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
extension UsersListViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != ""{
            let urlStr = Urls.baseURL.appending(Urls.secondURL.searchUser.rawValue)+searchText

getUsersListRequest(urlStr: urlStr)
            
        }else{
            //API Request
            let urlStr = Urls.baseURL.appending(Urls.secondURL.allUsers.rawValue)
            getUsersListRequest(urlStr: urlStr)
        }
    }
    
}

