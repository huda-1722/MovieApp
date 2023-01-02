//
//  ViewController.swift
//  MovieApp
//
//  Created by Huda  on 26/12/22.
//

import UIKit

class HomeVC : UIViewController {
    
    // MARK: - IBOutlets
    //=====================================
    @IBOutlet weak var moviesTableView: UITableView!
    
    // MARK: - Lifecycle
    //====================================
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.registerCell(with: PopluarMoviesTableCell.self)
        moviesTableView.registerCell(with: NowPlayingTableCell.self)
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    private func moveToDetailVC(data : Int) {
        let vc = MovieDetailVC.instantiate(fromAppStoryboard: .Main)
        vc.movieId = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - TableViewDelegate & DataSource
//============================================
extension HomeVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueCell(with: NowPlayingTableCell.self)
            cell.passData = { [weak self] cellData in
                self?.moveToDetailVC(data: cellData)
            }
            return cell
            
        } else {
            let cell = tableView.dequeueCell(with: PopluarMoviesTableCell.self)
            cell.passData = { [weak self] cellData in
                self?.moveToDetailVC(data: cellData)
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300
            
        }
        return 320
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 18))
        let label = UILabel(frame: CGRect(x:30, y:0, width:tableView.frame.size.width, height:18))
        if section == 0 {
            label.text = "Now Playing"
        } else {
            label.text = "Popular Movies"
        }
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        view.addSubview(label)
        self.view.addSubview(view)
        return view
    }
    
}
extension UIViewController {
    class var storyboardID: String {
        return "\(self)"
    }
    
}
