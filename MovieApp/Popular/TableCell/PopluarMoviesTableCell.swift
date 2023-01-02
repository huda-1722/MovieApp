//
//  PopluarMoviesTableCell.swift
//  MovieApp
//
//  Created by Huda  on 26/12/22.
//

import UIKit

class PopluarMoviesTableCell: UITableViewCell {
    
    // MARK: - IBOutlets
    //=====================================
    @IBOutlet weak var popularCollectionView: UICollectionView!
    
    //MARK: PROPERTIES
    //=================================
    private var viewModel : PopluarMoviesTableCellVM?
    var passData : (( _ data : Int) -> Void)? = nil
    
    //MARK: - CELL LIFE CYCLE
    //======================
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViewModel(vm: PopluarMoviesTableCellVM())
        setUpCollectionView()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

//MARK: - UICollectionViewDelegate & UICollectionViewDataSource
//=============================================================
extension PopluarMoviesTableCell : UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.getRowCount() ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let popularMovieCell = collectionView.dequeueCell(with: PopularMoviesCollectionCell.self, for: indexPath)
        let getData = viewModel?.getData(at : indexPath.item)
        popularMovieCell.populateData(data: getData ?? CommonMovieResult())
        return popularMovieCell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (self.viewModel?.getRowCount() ?? 0) - 2 {
            self.viewModel?.hitApi()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 5 , height:  collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let getData = viewModel?.getData(at: indexPath.row)
        passData?(getData?.id ?? 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

// MARK: - Extension for Private functions
//====================================
extension PopluarMoviesTableCell {
    private func setupViewModel(vm : PopluarMoviesTableCellVM) {
        guard self.viewModel == nil else { return }
        viewModel = vm
        viewModel?.delegate = self
        viewModel?.hitApi()
    }
    private func setUpCollectionView() {
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        popularCollectionView.registerCell(with: PopularMoviesCollectionCell.self)
    }
}
// MARK: - Extension of RefreshCollectonView
//==========================================
extension PopluarMoviesTableCell: RefreshCollectionViewProtocol {
    func refreshCollectionView() {
        popularCollectionView.reloadData()
    }
}

