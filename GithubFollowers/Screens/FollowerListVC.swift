//
//  FollowerListVC.swift
//  GithubFollowers
//
//  Created by Kaan Uzman on 13/8/23.
//

import UIKit

class FollowerListVC: GFDataLoadingVC {
    enum Section { case main }
    
    var username: String!
    lazy var followers: [Follower] = [] // i used lazy stored properties for improve performance
    lazy var filteredFollowers: [Follower] = [] // lazy stored properties for improve performance
    var page: Int = 1
    var hasMoreFollowers: Bool = true
    var isSearching: Bool = false
    var isLoadingMoreFollowers: Bool = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true // appbar large title centerTtile false for flutter codes
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func addButtonTapped() {
        showLoadingView()
        
        Task {
            do {
                let user = try await NetworkManager.shared.getUserInfo(for: username)
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                dismissLoadingView()
                addFollowerToFavoriteList(on: favorite)
            } catch {
                dismissLoadingView()
                if let gfError = error as? GFError {
                    presentGFAlert(
                        title: NSLocalizedString("something_wrong", comment: ""),
                        message: gfError.rawValue,
                        buttonTitle: NSLocalizedString("ok", comment: ""))
                } else {
                    presentDefaultGFAlert()
                }
            }
        }
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self

        searchController.searchBar.placeholder = NSLocalizedString("search_username", comment: "")
        searchController.obscuresBackgroundDuringPresentation = false // When Searchcontroller is clicked, removes light dimming applied to CollectionView
        navigationItem.searchController = searchController
    }
    
    private func getFollowers(username: String, page: Int) {
        showLoadingView()
        isLoadingMoreFollowers = true
        
        Task {
            do {
                let followers = try await NetworkManager.shared.getFollowers(for: username, page: page)
                updateUI(with: followers)
                dismissLoadingView()
            } catch {
                if let gfError = error as? GFError {
                    presentGFAlert(
                        title: NSLocalizedString("bad_stuff", comment: ""),
                        message: gfError.rawValue,
                        buttonTitle: NSLocalizedString("ok", comment: ""))
                } else {
                    presentDefaultGFAlert()
                }
                dismissLoadingView()
            }
        }
    }
    
    private func updateUI(with followers: [Follower]) {
        if followers.count < 100 { hasMoreFollowers = false }
        self.followers.append(contentsOf: followers)
        
        if self.followers.isEmpty {
            let message = NSLocalizedString("doesnt_any_followers", comment: "")
            DispatchQueue.main.async {
                self.navigationItem.hidesSearchBarWhenScrolling = true
                self.showEmptyStateView(with: message, in: self.view)
            }
        }
        
        updateData(on: self.followers)
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    private func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
}

extension FollowerListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            isSearching = false
            return
        }

        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        isSearching = true
        updateData(on: filteredFollowers)
    }
    
    // On tapped follower list item this functions running.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        let destinationVC = UserInfoVC()
        destinationVC.username = follower.login
        destinationVC.delegate = self
        let navigationController = UINavigationController(rootViewController: destinationVC)
        
        present(navigationController, animated: true)
    }
}

extension FollowerListVC: UserInfoVCDelegate {
    func didRequestFollowers(for username: String) {
        // get followers for that username
        self.username = username
        title = username
        page = 1
        hasMoreFollowers = true
        isSearching = false
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
    }
}
