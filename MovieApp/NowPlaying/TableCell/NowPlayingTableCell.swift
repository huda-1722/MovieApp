//
//  NowPlayingTableCell.swift
//  MovieApp
//
//  Created by Huda  on 26/12/22.
//

import UIKit
import CoreAudio


protocol RefreshCollectionViewProtocol: NSObject{
    func refreshCollectionView()
}

class NowPlayingTableCell: UITableViewCell {
    
    // MARK: - IBOutlets
    //=====================================
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    
    //MARK: PROPERTIES
    //=================================
    var passData : (( _ data : Int) -> Void)? = nil
    private var viewModel : NowPlayingTableCellVM?
    
    //MARK: - CELL LIFE CYCLE
    //======================
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViewModel(vm: NowPlayingTableCellVM())
        setUpCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

//MARK: - UICollectionViewDelegate & UICollectionViewDataSource
//=============================================================
extension NowPlayingTableCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.getRowCount() ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let nowPlayingCell = collectionView.dequeueCell(with: NowPlayingCollectionCell.self, for: indexPath)
        let getData = viewModel?.getData(at : indexPath.item)
        nowPlayingCell.populateData(data: getData ?? CommonMovieResult())
        return nowPlayingCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let getData = viewModel?.getData(at: indexPath.row)
        passData?(getData?.id ?? 0)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (self.viewModel?.getRowCount() ?? 0) - 2 {
            self.viewModel?.hitApi()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(indexPath.row)
        return CGSize(width: 250  , height:  collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}
// MARK: - Extension for Private functions
//====================================
extension NowPlayingTableCell {
    private func setupViewModel(vm : NowPlayingTableCellVM) {
        guard self.viewModel == nil else { return }
        viewModel = vm
        viewModel?.delegate = self
        viewModel?.hitApi()
    }
    private func setUpCollectionView() {
        nowPlayingCollectionView.delegate = self
        nowPlayingCollectionView.dataSource = self
        nowPlayingCollectionView.registerCell(with: NowPlayingCollectionCell.self)
    }
}

// MARK: - Extension of RefreshCollectonView
//==========================================
extension NowPlayingTableCell: RefreshCollectionViewProtocol {
    func refreshCollectionView() {
        nowPlayingCollectionView.reloadData()
    }
}
