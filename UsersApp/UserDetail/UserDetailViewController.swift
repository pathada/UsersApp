//
//  UserDetailViewController.swift
//  UsersApp
//
//  Created by Padmaja Pathada on 3/30/23.
//

import UIKit
import MapKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var tableVW: UITableView!
    @IBOutlet weak var profileImgVW: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    
    let UserImageCell = "UserImageCell"
    let UserNameCell = "UserNameCell"
    let UserDetailCell = "UserDetailCell"

    var userInfoObj : userInfo? = nil
    var ownerUserInfo : userInfo? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        tableVW.register(UINib(nibName: "UserImageTableViewCell", bundle: nil), forCellReuseIdentifier: UserImageCell)
        tableVW.register(UINib(nibName: "UsernameTableViewCell", bundle: nil), forCellReuseIdentifier: UserNameCell)
        tableVW.register(UINib(nibName: "UserDetailTableViewCell", bundle: nil), forCellReuseIdentifier: UserDetailCell)
        if userInfoObj == nil && ownerUserInfo != nil{
            userInfoObj = ownerUserInfo
        }
        
        updateUI()

    }
    func updateUI(){
        
        if let username = userInfoObj?.username{
            usernameLbl.text = username
        }
        downloadingImage()
    }
    func downloadingImage(){
        if let imageUrlStr = userInfoObj?.image{
            APIManager.shared.downloadImage(imageUrlStr) { image, urlString in
                if let imageObject = image{
                    // performing UI operation on main thread
                        self.profileImgVW.image = imageObject
                }
            }
        }
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
extension UserDetailViewController:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return 1
        }else{
            return 5
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       // let cell = UITableViewCell()
      if indexPath.section == 0{
            let imageCell = tableView.dequeueReusableCell(withIdentifier:UserImageCell) as? UserImageTableViewCell
          imageCell?.selectionStyle = UITableViewCell.SelectionStyle.none

           
            if let imageUrlObj = userInfoObj?.image{
                APIManager.shared.downloadImage(imageUrlObj) { image, urlString in
                    if let imageObj = image{
                        imageCell?.userImageVw.image = imageObj
                    }
                }
            }
            return imageCell ?? UITableViewCell()
        }
        else if indexPath.section == 1{
            let usernameCell = tableView.dequeueReusableCell(withIdentifier:UserNameCell , for: indexPath) as? UsernameTableViewCell
            usernameCell?.selectionStyle = UITableViewCell.SelectionStyle.none

            if let username = userInfoObj?.username{
                usernameCell?.userNameLbl.text = username
            }
            return usernameCell ?? UITableViewCell()
        }
        else{
            let detailCell = tableView.dequeueReusableCell(withIdentifier:UserDetailCell , for: indexPath) as? UserDetailTableViewCell
            detailCell?.selectionStyle = UITableViewCell.SelectionStyle.none
            detailCell?.mapImage.isHidden = true
            if indexPath.row == 0{
                detailCell?.detailNameLbl.text = "FirstName"
                if let firstName = userInfoObj?.firstName{
                    detailCell?.detailValueLbl.text = firstName
                }
            }
            if indexPath.row == 1{
                detailCell?.detailNameLbl.text = "LastName"
                if let lastName = userInfoObj?.lastName{
                    detailCell?.detailValueLbl.text = lastName
                }
            }
            if indexPath.row == 2{
                detailCell?.detailNameLbl.text = "Email"
                if let email = userInfoObj?.email{
                    detailCell?.detailValueLbl.text = email
                }
            }
            if indexPath.row == 3{
                detailCell?.detailNameLbl.text = "Phone"
                if let phone = userInfoObj?.phone{
                    detailCell?.detailValueLbl.text = phone
                }
            }
            if indexPath.row == 4{
                detailCell?.detailNameLbl.text = "Address"
                if let address = userInfoObj?.address?.address{
                    detailCell?.detailValueLbl.text = address
                    detailCell?.mapImage.isHidden = false
                }
            }
            return detailCell ?? UITableViewCell()
        }
        
       
        /*
        var cell = tableView.dequeueReusableCell(withIdentifier: UserImageCell) as? UserDetailsTableViewCell
        if cell == nil{
            let array = Bundle.main.loadNibNamed("UserDetailsTableViewCell", owner: self)
            _ = array.map({ value in
                print(value)
                if (value as? UITableViewCell)?.restorationIdentifier == UserImageCell{
                    cell = value as? UserDetailsTableViewCell
                }
            })
        }
        return cell ?? UITableViewCell()
        */
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 100
        }else if indexPath.section == 1{
            return 50
        }else{
            return 50
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row: \(indexPath.row)")
        if indexPath.row == 4{
            if let lat = userInfoObj?.address?.coordinates?.lat, let lng = userInfoObj?.address?.coordinates?.lng{
                let source = MKMapItem(coordinate: .init(latitude: lat, longitude: lng), name: "Source")
                let destination = MKMapItem(coordinate: .init(latitude: lat, longitude: lng), name: "Destination")
                
                MKMapItem.openMaps(
                    with: [source, destination],
                    launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                )
            }
        }
        
    }
}
extension MKMapItem {
  convenience init(coordinate: CLLocationCoordinate2D, name: String) {
    self.init(placemark: .init(coordinate: coordinate))
    self.name = name
  }
}
